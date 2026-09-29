import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type, x-wayl-signature-256",
  "Access-Control-Allow-Methods":
    "POST, OPTIONS",
};

// -----------------------------------------
// Convert ArrayBuffer to HEX
// -----------------------------------------

function bufferToHex(buffer: ArrayBuffer): string {
  return Array.from(
    new Uint8Array(buffer),
  )
    .map((byte) =>
      byte.toString(16).padStart(2, "0"),
    )
    .join("");
}

// -----------------------------------------
// Compare signatures safely
// -----------------------------------------

function safeCompare(
  a: string,
  b: string,
): boolean {
  if (a.length !== b.length) {
    return false;
  }

  let result = 0;

  for (let i = 0; i < a.length; i++) {
    result |=
      a.charCodeAt(i) ^
      b.charCodeAt(i);
  }

  return result === 0;
}

// -----------------------------------------
// HMAC SHA256
// -----------------------------------------

async function createHmac(
  secret: string,
  body: string,
): Promise<string> {
  const encoder =
    new TextEncoder();

  const key =
    await crypto.subtle.importKey(
      "raw",

      encoder.encode(secret),

      {
        name: "HMAC",
        hash: "SHA-256",
      },

      false,

      ["sign"],
    );

  const signature =
    await crypto.subtle.sign(
      "HMAC",
      key,
      encoder.encode(body),
    );

  return bufferToHex(signature);
}

// -----------------------------------------
// WEBHOOK
// -----------------------------------------

Deno.serve(async (req) => {
  // -----------------------------------------
  // OPTIONS
  // -----------------------------------------

  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: corsHeaders,
    });
  }

  if (req.method !== "POST") {
    return new Response(
      JSON.stringify({
        success: false,
        message: "Method not allowed",
      }),
      {
        status: 405,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  }

  try {
    // -----------------------------------------
    // Secrets
    // -----------------------------------------

    const webhookSecret =
      Deno.env.get(
        "WAYL_WEBHOOK_SECRET",
      );

    const supabaseUrl =
      Deno.env.get("SUPABASE_URL");

    const serviceRoleKey =
      Deno.env.get(
        "SUPABASE_SERVICE_ROLE_KEY",
      );

    if (
      !webhookSecret ||
      !supabaseUrl ||
      !serviceRoleKey
    ) {
      return new Response(
        JSON.stringify({
          success: false,
          message:
            "Missing server configuration",
        }),
        {
          status: 500,
          headers: {
            ...corsHeaders,
            "Content-Type":
              "application/json",
          },
        },
      );
    }

    // -----------------------------------------
    // IMPORTANT:
    // Read RAW body
    // before JSON.parse
    // -----------------------------------------

    const rawBody =
      await req.text();

    // -----------------------------------------
    // Get Wayl signature
    // -----------------------------------------

    const receivedSignature =
      req.headers.get(
        "x-wayl-signature-256",
      );

    if (!receivedSignature) {
      console.error(
        "Missing Wayl signature",
      );

      return new Response(
        JSON.stringify({
          success: false,
          message:
            "Missing signature",
        }),
        {
          status: 401,
          headers: {
            ...corsHeaders,
            "Content-Type":
              "application/json",
          },
        },
      );
    }

    // -----------------------------------------
    // Calculate signature
    // -----------------------------------------

    const expectedSignature =
      await createHmac(
        webhookSecret,
        rawBody,
      );

    // -----------------------------------------
    // Verify signature
    // -----------------------------------------

    if (
      !safeCompare(
        receivedSignature.toLowerCase(),
        expectedSignature.toLowerCase(),
      )
    ) {
      console.error(
        "Invalid Wayl signature",
      );

      return new Response(
        JSON.stringify({
          success: false,
          message:
            "Invalid signature",
        }),
        {
          status: 401,
          headers: {
            ...corsHeaders,
            "Content-Type":
              "application/json",
          },
        },
      );
    }

    // -----------------------------------------
    // Parse webhook
    // -----------------------------------------

    const webhook =
      JSON.parse(rawBody);

    console.log(
      "Wayl webhook:",
      JSON.stringify(webhook),
    );

    // -----------------------------------------
    // Extract data
    // -----------------------------------------

    const referenceId =
      webhook.referenceId;

    const paymentStatus =
      webhook.paymentStatus;

    const event =
      webhook.event;

    const paymentMethod =
      webhook.paymentMethod;

    // -----------------------------------------
    // Validate reference
    // -----------------------------------------

    if (!referenceId) {
      return new Response(
        JSON.stringify({
          success: false,
          message:
            "referenceId is missing",
        }),
        {
          status: 400,
          headers: {
            ...corsHeaders,
            "Content-Type":
              "application/json",
          },
        },
      );
    }

    // -----------------------------------------
    // Supabase Admin
    // -----------------------------------------

    const supabaseAdmin =
      createClient(
        supabaseUrl,
        serviceRoleKey,
      );

    // -----------------------------------------
    // Determine our status
    // -----------------------------------------

    const normalizedStatus =
      String(
        paymentStatus ?? "",
      ).toLowerCase();

    let status =
      "PROCESSING";

    if (
      normalizedStatus === "paid" ||
      normalizedStatus === "success" ||
      normalizedStatus === "successful" ||
      normalizedStatus === "completed" ||
      normalizedStatus === "completed_successfully"
    ) {
      status = "PAID";
    }

    if (
      normalizedStatus === "failed" ||
      normalizedStatus === "failure" ||
      normalizedStatus === "cancelled" ||
      normalizedStatus === "canceled" ||
      normalizedStatus === "expired"
    ) {
      status = "FAILED";
    }

    // -----------------------------------------
    // Update payment
    // -----------------------------------------

    const { data, error } =
      await supabaseAdmin
        .from("payments")
        .update({
          status: status,

          payment_status:
            paymentStatus ?? null,

          payment_method:
            paymentMethod ?? null,

          webhook_event:
            event ?? null,

          updated_at:
            new Date().toISOString(),
        })
        .eq(
          "reference_id",
          referenceId,
        )
        .select()
        .maybeSingle();

    if (error) {
      console.error(
        "Database update error:",
        error,
      );

      return new Response(
        JSON.stringify({
          success: false,
          message:
            "Failed to update payment",
        }),
        {
          status: 500,
          headers: {
            ...corsHeaders,
            "Content-Type":
              "application/json",
          },
        },
      );
    }

    // -----------------------------------------
    // Payment not found
    // -----------------------------------------

    if (!data) {
      console.error(
        "Payment not found:",
        referenceId,
      );

      return new Response(
        JSON.stringify({
          success: false,
          message:
            "Payment not found",
          referenceId,
        }),
        {
          status: 404,
          headers: {
            ...corsHeaders,
            "Content-Type":
              "application/json",
          },
        },
      );
    }

    // -----------------------------------------
    // Success
    // -----------------------------------------

    console.log(
      `Payment ${referenceId} updated to ${status}`,
    );

    return new Response(
      JSON.stringify({
        success: true,
        referenceId,
        status,
      }),
      {
        status: 200,
        headers: {
          ...corsHeaders,
          "Content-Type":
            "application/json",
        },
      },
    );
  } catch (error) {
    console.error(
      "Webhook error:",
      error,
    );

    return new Response(
      JSON.stringify({
        success: false,

        message:
          error instanceof Error
            ? error.message
            : "Webhook error",
      }),
      {
        status: 500,

        headers: {
          ...corsHeaders,
          "Content-Type":
            "application/json",
        },
      },
    );
  }
});
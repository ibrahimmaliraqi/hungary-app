import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods":
    "POST, OPTIONS",
};

Deno.serve(async (req) => {
  // -----------------------------------------
  // CORS
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
    // ENV
    // -----------------------------------------

    const waylToken =
      Deno.env.get("WAYL_API_TOKEN");

    const webhookSecret =
      Deno.env.get("WAYL_WEBHOOK_SECRET");

    const supabaseUrl =
      Deno.env.get("SUPABASE_URL");

    const serviceRoleKey =
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

    if (!waylToken ||
        !webhookSecret ||
        !supabaseUrl ||
        !serviceRoleKey) {
      return new Response(
        JSON.stringify({
          success: false,
          message: "Missing environment variables",
        }),
        {
          status: 500,
          headers: {
            ...corsHeaders,
            "Content-Type": "application/json",
          },
        },
      );
    }

    // -----------------------------------------
    // Supabase Admin
    // -----------------------------------------

    const supabaseAdmin = createClient(
      supabaseUrl,
      serviceRoleKey,
    );

    // -----------------------------------------
    // Request body
    // -----------------------------------------

    const body = await req.json();

    finalCheck(body);

    const amount = Number(body.amount);

    const customerName =
      body.customerName ?? "";

    const customerPhone =
      body.customerPhone ?? "";

    // -----------------------------------------
    // Validate amount
    // -----------------------------------------

    if (!Number.isInteger(amount) || amount <= 0) {
      return new Response(
        JSON.stringify({
          success: false,
          message: "Invalid amount",
        }),
        {
          status: 400,
          headers: {
            ...corsHeaders,
            "Content-Type": "application/json",
          },
        },
      );
    }

    // -----------------------------------------
    // Reference ID
    // -----------------------------------------

    const referenceId =
      `TEST_${crypto.randomUUID()}`;

    // -----------------------------------------
    // URLs
    // -----------------------------------------

    const webhookUrl =
      `${supabaseUrl}/functions/v1/wayl-webhook`;

    const redirectionUrl =
      "https://example.com/payment-result";

    // -----------------------------------------
    // Wayl body
    // -----------------------------------------

    const waylBody = {
      env: "test",

      referenceId: referenceId,

      total: amount,

      currency: "IQD",

      customParameter: "test",

      lineItem: [
        {
          label: "Hungry App Order",

          amount: amount,

          type: "increase",
        },
      ],

      webhookUrl: webhookUrl,

      webhookSecret: webhookSecret,

      redirectionUrl: redirectionUrl,
    };

    // -----------------------------------------
    // Create Wayl payment
    // -----------------------------------------

    const waylResponse = await fetch(
      "https://api.thewayl.com/api/v1/links",
      {
        method: "POST",

        headers: {
          "Content-Type": "application/json",

          "X-WAYL-AUTHENTICATION":
            waylToken,
        },

        body: JSON.stringify(waylBody),
      },
    );

    const waylData =
      await waylResponse.json();

    // -----------------------------------------
    // Wayl error
    // -----------------------------------------

    if (!waylResponse.ok) {
      console.error(
        "Wayl error:",
        JSON.stringify(waylData),
      );

      return new Response(
        JSON.stringify({
          success: false,

          message:
            waylData?.message ??
            waylData?.error?.message ??
            "Wayl request failed",

          error: waylData,
        }),
        {
          status: waylResponse.status,

          headers: {
            ...corsHeaders,
            "Content-Type": "application/json",
          },
        },
      );
    }

    // -----------------------------------------
    // Payment data
    // -----------------------------------------

    const payment =
      waylData?.data;

    if (!payment?.url) {
      return new Response(
        JSON.stringify({
          success: false,
          message: "Wayl did not return checkout URL",
          response: waylData,
        }),
        {
          status: 502,
          headers: {
            ...corsHeaders,
            "Content-Type": "application/json",
          },
        },
      );
    }

    // -----------------------------------------
    // Save payment
    // PROCESSING
    // -----------------------------------------

    const { error: insertError } =
      await supabaseAdmin
        .from("payments")
        .insert({
          reference_id:
            payment.referenceId ??
            referenceId,

          wayl_id:
            payment.id ?? null,

          wayl_code:
            payment.code ?? null,

          amount:
            Number(payment.total ?? amount),

          currency:
            payment.currency ?? "IQD",

          status:
            "PROCESSING",

          customer_name:
            customerName,

          customer_phone:
            customerPhone,

          checkout_url:
            payment.url,

          payment_status:
            payment.status ?? null,

          created_at:
            new Date().toISOString(),

          updated_at:
            new Date().toISOString(),
        });

    if (insertError) {
      console.error(
        "Database insert error:",
        insertError,
      );

      return new Response(
        JSON.stringify({
          success: false,
          message:
            "Payment created in Wayl but failed to save",
          error: insertError.message,
        }),
        {
          status: 500,
          headers: {
            ...corsHeaders,
            "Content-Type": "application/json",
          },
        },
      );
    }

    // -----------------------------------------
    // Success
    // -----------------------------------------

    return new Response(
      JSON.stringify({
        success: true,

        referenceId:
          payment.referenceId ??
          referenceId,

        waylId:
          payment.id ?? null,

        code:
          payment.code ?? null,

        amount:
          payment.total ?? amount,

        status:
          "PROCESSING",

        checkoutUrl:
          payment.url,
      }),
      {
        status: 200,

        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  } catch (error) {
    console.error(error);

    return new Response(
      JSON.stringify({
        success: false,

        message:
          error instanceof Error
            ? error.message
            : "Internal server error",
      }),
      {
        status: 500,

        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  }
});

function finalCheck(body: any) {
  if (!body) {
    throw new Error("Request body is required");
  }
}
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { serve } from "https://deno.land/std@0.224.0/http/server.ts";

const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

async function generateHmac(
  secret: string,
  message: string,
): Promise<string> {
  const encoder = new TextEncoder();

  const key = await crypto.subtle.importKey(
    "raw",
    encoder.encode(secret),
    {
      name: "HMAC",
      hash: "SHA-256",
    },
    false,
    ["sign"],
  );

  const signature = await crypto.subtle.sign(
    "HMAC",
    key,
    encoder.encode(message),
  );

  return Array.from(
    new Uint8Array(signature),
  )
    .map((byte) => byte.toString(16).padStart(2, "0"))
    .join("");
}

function safeCompare(
  a: string,
  b: string,
): boolean {
  if (a.length !== b.length) {
    return false;
  }

  let result = 0;

  for (let i = 0; i < a.length; i++) {
    result |= a.charCodeAt(i) ^
      b.charCodeAt(i);
  }

  return result === 0;
}

serve(async (req) => {
  try {
    // مهم جداً:
    // نقرأ الـ raw body قبل JSON.parse
    const rawBody = await req.text();

    const signatureHeader = req.headers.get(
      "X-SwiftPay-Signature",
    );

    if (!signatureHeader) {
      return new Response(
        "Missing signature",
        {
          status: 401,
        },
      );
    }

    const webhookSecret = Deno.env.get(
      "SWIFTPAY_WEBHOOK_SECRET",
    );

    if (!webhookSecret) {
      return new Response(
        "Webhook secret not configured",
        {
          status: 500,
        },
      );
    }

    // مثال:
    // t=1750000000,v1=abcdef...
    const parts = signatureHeader.split(",");

    let timestamp = "";
    let signature = "";

    for (const part of parts) {
      const [key, value] = part.split("=");

      if (key === "t") {
        timestamp = value;
      }

      if (key === "v1") {
        signature = value;
      }
    }

    if (!timestamp || !signature) {
      return new Response(
        "Invalid signature",
        {
          status: 401,
        },
      );
    }

    // منع Replay Attack
    const timestampNumber = Number(timestamp);

    const currentTime = Math.floor(Date.now() / 1000);

    if (
      Math.abs(
        currentTime - timestampNumber,
      ) > 300
    ) {
      return new Response(
        "Expired signature",
        {
          status: 401,
        },
      );
    }

    // SwiftPay:
    // t + "." + rawBody
    const signedPayload = `${timestamp}.${rawBody}`;

    const expectedSignature = await generateHmac(
      webhookSecret,
      signedPayload,
    );

    if (
      !safeCompare(
        expectedSignature,
        signature,
      )
    ) {
      return new Response(
        "Invalid signature",
        {
          status: 401,
        },
      );
    }

    // الآن فقط نقرأ JSON
    const payload = JSON.parse(rawBody);

    const event = payload.event;

    const payment = payload.data;

    console.log(
      "SwiftPay Event:",
      event,
    );

    console.log(
      "SwiftPay Payment:",
      payment,
    );

    if (
      event ===
        "payment.succeeded" ||
      event ===
        "payment_link.paid"
    ) {
      const { error } = await supabase
        .from("swiftpat")
        .update({
          status: "PAID",
          payment_id: payment.paymentId,
          gateway_txn_id: payment.gatewayTxnId,
          provider: payment.provider,
          updated_at: new Date().toISOString(),
        })
        .eq(
          "payment_link_id",
          payment.paymentLinkId,
        );

      if (error) {
        console.error(
          "PAID update error:",
          error,
        );

        return new Response(
          "Database error",
          {
            status: 500,
          },
        );
      }
    }

    if (
      event ===
        "payment.failed"
    ) {
      const { error } = await supabase
        .from("swiftpat")
        .update({
          status: "FAILED",
          payment_id: payment.paymentId,
          gateway_txn_id: payment.gatewayTxnId,
          provider: payment.provider,
          updated_at: new Date().toISOString(),
        })
        .eq(
          "payment_link_id",
          payment.paymentLinkId,
        );

      if (error) {
        console.error(
          "FAILED update error:",
          error,
        );

        return new Response(
          "Database error",
          {
            status: 500,
          },
        );
      }
    }

    if (
      event ===
        "payment.refunded"
    ) {
      const { error } = await supabase
        .from("swiftpat")
        .update({
          status: "REFUNDED",
          payment_id: payment.paymentId,
          gateway_txn_id: payment.gatewayTxnId,
          provider: payment.provider,
          updated_at: new Date().toISOString(),
        })
        .eq(
          "payment_link_id",
          payment.paymentLinkId,
        );

      if (error) {
        console.error(
          "REFUNDED update error:",
          error,
        );

        return new Response(
          "Database error",
          {
            status: 500,
          },
        );
      }
    }

    // لازم نرجع 2xx بسرعة
    return new Response(
      JSON.stringify({
        received: true,
      }),
      {
        status: 200,
        headers: {
          "Content-Type": "application/json",
        },
      },
    );
  } catch (error) {
    console.error(error);

    return new Response(
      JSON.stringify({
        received: false,
      }),
      {
        status: 500,
        headers: {
          "Content-Type": "application/json",
        },
      },
    );
  }
});

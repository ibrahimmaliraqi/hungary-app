import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { serve } from "https://deno.land/std@0.224.0/http/server.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: corsHeaders,
    });
  }

  try {
    finalHandler: {
      const body = await req.json();

      const {
        orderId,
        title,
        amount,
        customerName,
        customerPhone,
      } = body;

      if (!title || !amount) {
        return new Response(
          JSON.stringify({
            success: false,
            message: "title and amount are required",
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

      const swiftPayKey = Deno.env.get("SWIFTPAY_SECRET_KEY");

      if (!swiftPayKey) {
        throw new Error(
          "SWIFTPAY_SECRET_KEY is not configured",
        );
      }

      // إنشاء Payment Link في SwiftPay
      const swiftPayResponse = await fetch(
        "https://api.swiftpayiq.com/api/v1/payment-links",
        {
          method: "POST",
          headers: {
            "Authorization": `Bearer ${swiftPayKey}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            title: title,
            amount: String(amount),
            isReusable: false,
            customerName: customerName,
            customerPhone: customerPhone,
          }),
        },
      );

      const swiftPayData = await swiftPayResponse.json();

      if (!swiftPayResponse.ok) {
        return new Response(
          JSON.stringify({
            success: false,
            message: "SwiftPay error",
            error: swiftPayData,
          }),
          {
            status: swiftPayResponse.status,
            headers: {
              ...corsHeaders,
              "Content-Type": "application/json",
            },
          },
        );
      }

      const paymentLinkId = swiftPayData.id ??
        swiftPayData.paymentLinkId;

      const payPageUrl = swiftPayData.payPageUrl;

      if (!paymentLinkId || !payPageUrl) {
        throw new Error(
          "SwiftPay did not return payment link information",
        );
      }

      // إضافة العملية إلى Supabase
      const { data: paymentRecord, error } = await supabase
        .from("swiftpat")
        .insert({
          order_id: orderId,
          payment_link_id: paymentLinkId,
          title: title,
          amount: Number(amount),
          customer_name: customerName,
          customer_phone: customerPhone,
          status: "PROCESSING",
          pay_page_url: payPageUrl,
        })
        .select()
        .single();

      if (error) {
        console.error(
          "Database insert error:",
          error,
        );

        return new Response(
          JSON.stringify({
            success: false,
            message: "Payment link created but database insert failed",
            error: error.message,
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

      return new Response(
        JSON.stringify({
          success: true,
          payment: paymentRecord,
          payPageUrl: payPageUrl,
        }),
        {
          status: 200,
          headers: {
            ...corsHeaders,
            "Content-Type": "application/json",
          },
        },
      );
    }
  } catch (error) {
    console.error(error);

    return new Response(
      JSON.stringify({
        success: false,
        message: error instanceof Error ? error.message : "Unknown error",
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

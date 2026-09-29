const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods":
    "POST, OPTIONS",
};

Deno.serve(async (req) => {
  // ------------------------------------------
  // CORS
  // ------------------------------------------

  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: corsHeaders,
    });
  }

  // ------------------------------------------
  // Allow POST only
  // ------------------------------------------

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
    // ------------------------------------------
    // Environment variables
    // ------------------------------------------

    const waylToken =
      Deno.env.get("WAYL_API_TOKEN");

    const webhookSecret =
      Deno.env.get("WAYL_WEBHOOK_SECRET");

    const supabaseUrl =
      Deno.env.get("SUPABASE_URL");

    if (!waylToken) {
      console.error(
        "WAYL_API_TOKEN is missing",
      );

      return new Response(
        JSON.stringify({
          success: false,
          message: "WAYL_API_TOKEN is missing",
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

    if (!webhookSecret) {
      console.error(
        "WAYL_WEBHOOK_SECRET is missing",
      );

      return new Response(
        JSON.stringify({
          success: false,
          message:
            "WAYL_WEBHOOK_SECRET is missing",
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

    if (!supabaseUrl) {
      console.error(
        "SUPABASE_URL is missing",
      );

      return new Response(
        JSON.stringify({
          success: false,
          message: "SUPABASE_URL is missing",
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

    // ------------------------------------------
    // Read request body
    // ------------------------------------------

    const body = await req.json();

    const amount = Number(body.amount);

    // ------------------------------------------
    // Validate amount
    // ------------------------------------------

    if (!Number.isInteger(amount) || amount <= 0) {
      return new Response(
        JSON.stringify({
          success: false,
          message:
            "amount must be a positive integer",
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

    // ------------------------------------------
    // Generate unique reference ID
    // ------------------------------------------

    const referenceId =
      `TEST_${crypto.randomUUID()}`;

    // ------------------------------------------
    // Webhook URL
    // ------------------------------------------

    const webhookUrl =
      `${supabaseUrl}/functions/v1/wayl-webhook`;

    // ------------------------------------------
    // Redirection URL
    // ------------------------------------------
    //
    // مؤقتًا للتجربة فقط.
    //
    // لاحقًا نقدر نغيره إلى رابط تطبيقك.
    //

    const redirectionUrl =
      "https://example.com/payment-result";

    // ------------------------------------------
    // Request body for Wayl
    // ------------------------------------------

    const waylRequestBody = {
      env: "test",

      referenceId: referenceId,

      total: amount,

      currency: "IQD",

      customParameter: "test",

      lineItem: [
        {
          label: "Test Invoice",

          amount: amount,

          type: "increase",
        },
      ],

      webhookUrl: webhookUrl,

      webhookSecret: webhookSecret,

      redirectionUrl: redirectionUrl,
    };

    console.log(
      "Creating Wayl test payment:",
      JSON.stringify({
        ...waylRequestBody,

        // لا نطبع الـ secret في logs
        webhookSecret: "***",
      }),
    );

    // ------------------------------------------
    // Call Wayl API
    // ------------------------------------------

    const waylResponse = await fetch(
      "https://api.thewayl.com/api/v1/links",
      {
        method: "POST",

        headers: {
          "Content-Type": "application/json",

          "X-WAYL-AUTHENTICATION":
            waylToken,
        },

        body: JSON.stringify(
          waylRequestBody,
        ),
      },
    );

    // ------------------------------------------
    // Read Wayl response
    // ------------------------------------------

    const waylData =
      await waylResponse.json();

    console.log(
      "Wayl status:",
      waylResponse.status,
    );

    // ------------------------------------------
    // Wayl error
    // ------------------------------------------

    if (!waylResponse.ok) {
      console.error(
        "Wayl API error:",
        JSON.stringify(waylData),
      );

      return new Response(
        JSON.stringify({
          success: false,

          message:
            waylData?.message ??
            waylData?.error?.message ??
            "Wayl API request failed",

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

    // ------------------------------------------
    // Extract payment data
    // ------------------------------------------

    const payment =
      waylData?.data;

    if (!payment) {
      console.error(
        "Wayl response does not contain data",
      );

      return new Response(
        JSON.stringify({
          success: false,
          message:
            "Invalid response from Wayl",
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

    // ------------------------------------------
    // Return result to Flutter
    // ------------------------------------------

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

        currency:
          payment.currency ?? "IQD",

        status:
          payment.status ?? null,

        checkoutUrl:
          payment.url ?? null,

        message:
          waylData.message ??
          "Test payment created successfully",
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
    console.error(
      "Create Wayl test payment error:",
      error,
    );

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
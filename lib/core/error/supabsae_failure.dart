import 'package:supabase_flutter/supabase_flutter.dart';

class Failure {
  final String message;
  const Failure(this.message);
}

class SupabaseAuthError extends Failure {
  const SupabaseAuthError(super.message);

  factory SupabaseAuthError.from(Object error) {
    if (error is AuthException) {
      final msg = error.message.toLowerCase();

      switch (msg) {
        case _ when msg.contains("invalid login credentials"):
          return const SupabaseAuthError("الايميل او كلمة المرور غير صحيحة ❌");

        case _ when msg.contains("email not confirmed"):
          return const SupabaseAuthError("لازم تفعل البريد الالكتروني اولاً ✅");

        case _ when msg.contains("user already registered"):
          return const SupabaseAuthError("هذا الحساب مسجل مسبقاً ⚠️");

        case _
            when msg.contains("password should be at least") ||
                msg.contains("weak password"):
          return const SupabaseAuthError("كلمة المرور ضعيفة 😅");

        case _
            when msg.contains("too many requests") ||
                msg.contains("rate limit"):
          return const SupabaseAuthError("محاولات كثيرة.. حاول بعد شوي ⏳");

        default:
          return SupabaseAuthError("خطأ: ${error.message}");
      }
    }

    final txt = error.toString().toLowerCase();
    if (txt.contains("socketexception") ||
        txt.contains("failed host lookup") ||
        txt.contains("network")) {
      return const SupabaseAuthError("مشكلة بالانترنت 🌐");
    }

    return SupabaseAuthError("خطأ غير معروف: ${error.toString()}");
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart';

class Failure {
  final String message;
  const Failure(this.message);
}

class SupabaseAuthError extends Failure {
  const SupabaseAuthError(super.message);

  factory SupabaseAuthError.from(Object error) {
    /// ---------------- NETWORK ERRORS ----------------
    if (error is SocketException) {
      return const SupabaseAuthError(
        "لا يوجد اتصال بالإنترنت 🌐",
      );
    }

    if (error is ClientException) {
      return const SupabaseAuthError(
        "فشل الاتصال بالخادم، تحقق من الإنترنت 📡",
      );
    }

    final txt = error.toString().toLowerCase();
    if (txt.contains("no route to host") ||
        txt.contains("failed host lookup") ||
        txt.contains("network")) {
      return const SupabaseAuthError(
        "الإنترنت مقطوع، حاول مرة أخرى 🌍",
      );
    }

    /// ---------------- AUTH ERRORS ----------------
    if (error is AuthException) {
      final msg = error.message.toLowerCase();

      if (msg.contains("invalid login credentials")) {
        return const SupabaseAuthError(
          "الايميل او كلمة المرور غير صحيحة ❌",
        );
      }

      if (msg.contains("email not confirmed")) {
        return const SupabaseAuthError(
          "يرجى تفعيل البريد الإلكتروني أولاً ✅",
        );
      }

      if (msg.contains("user already registered")) {
        return const SupabaseAuthError(
          "هذا الحساب مسجل مسبقاً ⚠️",
        );
      }

      if (msg.contains("weak password") ||
          msg.contains("password should be at least")) {
        return const SupabaseAuthError(
          "كلمة المرور ضعيفة 😅",
        );
      }

      if (msg.contains("too many requests") || msg.contains("rate limit")) {
        return const SupabaseAuthError(
          "محاولات كثيرة، حاول لاحقاً ⏳",
        );
      }

      return SupabaseAuthError(
        "خطأ في تسجيل الدخول: ${error.message}",
      );
    }

    /// ---------------- DATABASE ERRORS ----------------
    if (error is PostgrestException) {
      final msg = error.message.toLowerCase();

      if (msg.contains("column") && msg.contains("does not exist")) {
        return SupabaseAuthError(
          // "اسم الحقل غير صحيح ❌",
          error.message,
        );
      }

      if (msg.contains("relation") && msg.contains("does not exist")) {
        return const SupabaseAuthError(
          "اسم الجدول غير موجود ❌",
        );
      }

      if (msg.contains("duplicate key") || msg.contains("already exists")) {
        return const SupabaseAuthError(
          "البيانات مسجلة مسبقاً ⚠️",
        );
      }

      if (msg.contains("null value") && msg.contains("not-null")) {
        return const SupabaseAuthError(
          "يرجى تعبئة جميع الحقول المطلوبة ❗",
        );
      }

      if (msg.contains("foreign key")) {
        return const SupabaseAuthError(
          "البيانات مرتبطة بجدول آخر 🔗",
        );
      }

      if (msg.contains("row level security") ||
          msg.contains("permission denied")) {
        return const SupabaseAuthError(
          "لا تملك صلاحية تنفيذ هذه العملية 🔒",
        );
      }

      return SupabaseAuthError(
        "خطأ قاعدة البيانات: ${error.message}",
      );
    }

    /// ---------------- UNKNOWN ----------------
    debugPrint("SUPABASE ERROR: $error");

    return SupabaseAuthError(
      "حدث خطأ غير متوقع ❗",
    );
  }
}

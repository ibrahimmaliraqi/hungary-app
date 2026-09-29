import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart';

class Failure {
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class SupabaseAuthError extends Failure {
  SupabaseAuthError({required super.message});

  factory SupabaseAuthError.from(Object error) {
    /// ---------------- NETWORK ERRORS ----------------
    if (error is SocketException) {
      return SupabaseAuthError(
        message: "لا يوجد اتصال بالإنترنت 🌐",
      );
    }

    if (error is ClientException) {
      return SupabaseAuthError(
        message: "فشل الاتصال بالخادم، تحقق من الإنترنت 📡",
      );
    }

    final txt = error.toString().toLowerCase();
    if (txt.contains("no route to host") ||
        txt.contains("failed host lookup") ||
        txt.contains("network")) {
      return SupabaseAuthError(
        message: "الإنترنت مقطوع، حاول مرة أخرى 🌍",
      );
    }

    /// ---------------- AUTH ERRORS ----------------
    if (error is AuthException) {
      final msg = error.message.toLowerCase();

      if (msg.contains("invalid login credentials")) {
        return SupabaseAuthError(
          message: "الايميل او كلمة المرور غير صحيحة ❌",
        );
      }

      if (msg.contains("email not confirmed")) {
        return SupabaseAuthError(
          message: "يرجى تفعيل البريد الإلكتروني أولاً ✅",
        );
      }

      if (msg.contains("user already registered")) {
        return SupabaseAuthError(
          message: "هذا الحساب مسجل مسبقاً ⚠️",
        );
      }

      if (msg.contains("weak password") ||
          msg.contains("password should be at least")) {
        return SupabaseAuthError(
          message: "كلمة المرور ضعيفة 😅",
        );
      }

      if (msg.contains("too many requests") || msg.contains("rate limit")) {
        return SupabaseAuthError(
          message: "محاولات كثيرة، حاول لاحقاً ⏳",
        );
      }

      return SupabaseAuthError(
        message: "خطأ في تسجيل الدخول: ${error.message}",
      );
    }

    /// ---------------- DATABASE ERRORS ----------------
    if (error is PostgrestException) {
      final msg = error.message.toLowerCase();

      if (msg.contains("column") && msg.contains("does not exist")) {
        return SupabaseAuthError(
          message:
              // "اسم الحقل غير صحيح ❌",
              error.message,
        );
      }

      if (msg.contains("relation") && msg.contains("does not exist")) {
        return SupabaseAuthError(
          message: "اسم الجدول غير موجود ❌",
        );
      }

      if (msg.contains("duplicate key") || msg.contains("already exists")) {
        return SupabaseAuthError(
          message: "البيانات مسجلة مسبقاً ⚠️",
        );
      }

      if (msg.contains("null value") && msg.contains("not-null")) {
        return SupabaseAuthError(
          message: "يرجى تعبئة جميع الحقول المطلوبة ❗",
        );
      }

      if (msg.contains("foreign key")) {
        return SupabaseAuthError(
          message: "البيانات مرتبطة بجدول آخر 🔗",
        );
      }

      if (msg.contains("row level security") ||
          msg.contains("permission denied")) {
        return SupabaseAuthError(
          message: "لا تملك صلاحية تنفيذ هذه العملية 🔒",
        );
      }

      return SupabaseAuthError(
        message: "خطأ قاعدة البيانات: ${error.message}",
      );
    }

    /// ---------------- UNKNOWN ----------------
    debugPrint("SUPABASE ERROR: $error");

    return SupabaseAuthError(
      message: "حدث خطأ غير متوقع ❗",
    );
  }
}

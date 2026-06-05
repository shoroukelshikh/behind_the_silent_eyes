import 'package:flutter/material.dart';

class AppColors {
  // ── Primary palette ──────────────────────────────────────────────
  static const Color navy       = Color(0xFF1A2744); // primary actions, appbar
  static const Color navyLight  = Color(0xFF2E3D5C); // secondary surfaces
  static const Color accent     = Color(0xFF2E7CF6); // links, focus, highlights
  static const Color accentLight= Color(0xFFEEF4FF); // accent background tint

  // ── Neutral surfaces ─────────────────────────────────────────────
  static const Color background = Color(0xFFF5F7FA); // page background
  static const Color surface    = Color(0xFFFFFFFF); // cards, inputs
  static const Color border     = Color(0xFFE4E9F2); // card/input borders
  static const Color borderDark = Color(0xFFCDD5E0); // focused / dividers

  // ── Text ─────────────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFF1A2744);
  static const Color textSecondary = Color(0xFF6B7899);
  static const Color textHint      = Color(0xFFADB8CC);

  // ── Semantic ─────────────────────────────────────────────────────
  static const Color success     = Color(0xFF1A7F50);
  static const Color successBg   = Color(0xFFEDFAF3);
  static const Color warning     = Color(0xFFC47A1A);
  static const Color warningBg   = Color(0xFFFFF8EE);
  static const Color danger      = Color(0xFFD13B37);
  static const Color dangerBg    = Color(0xFFFFF0EF);

  // ── Legacy gradient kept for any widget still referencing it ─────
  // (replaced in all screens — kept so nothing breaks at compile time)
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF5F7FA), Color(0xFFECF1FA)],
  );

  static const LinearGradient cardColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A2744), Color(0xFF2E3D5C)],
  );
}
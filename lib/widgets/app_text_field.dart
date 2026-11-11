import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final VoidCallback? onSuffixTap;
  final int maxLines;
  final IconData? icon;

  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.icon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.onSuffixTap,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePrefixIcon = prefixIcon ?? icon;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                const TextStyle(color: AppColors.textSecondary, fontSize: 14),
            prefixIcon: effectivePrefixIcon != null
                ? Icon(effectivePrefixIcon,
                    size: 20, color: AppColors.textSecondary)
                : null,
            suffixIcon: suffixIcon != null
                ? InkWell(
                    onTap: onSuffixTap,
                    child: Icon(suffixIcon,
                        size: 20, color: AppColors.textSecondary),
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

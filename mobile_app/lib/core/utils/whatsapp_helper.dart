import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class WhatsAppHelper {
  static Future<void> openWhatsApp(
    BuildContext context,
    String phoneNumber,
  ) async {
    // Basic cleanup for phone number, assuming international format without + might need handling
    // For now, assume phoneNumber is in a valid format or just numbers.
    // WhatsApp URL format: https://wa.me/<number>
    final Uri whatsappUrl = Uri.parse('https://wa.me/$phoneNumber');

    try {
      if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open WhatsApp')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}

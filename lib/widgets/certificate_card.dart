import 'package:flutter/material.dart';
import '../models/certificate.dart';
import 'app_card.dart';

// CUSTOM WIDGET: one certificate card (icon, title, org, year,
// description and a "View Certificate" button).
class CertificateCard extends StatelessWidget {
  final Certificate certificate;
  const CertificateCard({super.key, required this.certificate});

  // Opens a dialog. Shows the image if available, otherwise a placeholder.
  void _showCertificate(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  certificate.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: certificate.imagePath == null
                        ? _placeholder(scheme)
                        : Image.asset(
                            certificate.imagePath!,
                            fit: BoxFit.contain,
                            // errorBuilder runs if the file is missing.
                            errorBuilder: (_, __, ___) => _placeholder(scheme),
                          ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _placeholder(ColorScheme scheme) {
    return Container(
      height: 180,
      width: double.infinity,
      color: scheme.primaryContainer,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.image_not_supported_outlined,
              size: 48, color: scheme.onPrimaryContainer),
          const SizedBox(height: 8),
          Text(
            'Certificate image not added yet',
            textAlign: TextAlign.center,
            style: TextStyle(color: scheme.onPrimaryContainer),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: scheme.primaryContainer,
                child: Icon(certificate.icon, color: scheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(certificate.title, style: textTheme.titleMedium),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('${certificate.organization}  •  ${certificate.year}',
              style: textTheme.labelLarge?.copyWith(color: scheme.primary)),
          const SizedBox(height: 6),
          Text(certificate.description, style: textTheme.bodyMedium),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: () => _showCertificate(context),
              icon: const Icon(Icons.visibility_outlined),
              label: const Text('View Certificate'),
            ),
          ),
        ],
      ),
    );
  }
}

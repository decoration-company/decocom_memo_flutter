import 'package:flutter/material.dart';

class StoryLinkCard extends StatelessWidget {
  const StoryLinkCard({
    required this.title,
    required this.link,
    required this.isCopied,
    required this.onCopy,
    super.key,
  });

  final String title;
  final String link;
  final bool isCopied;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFE8E8EC)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onCopy,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isCopied ? const Color(0xFF3A3A42) : Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Text(
                isCopied ? '✓ Copied!' : 'Tap to copy',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isCopied
                      ? const Color(0xFFFF6B9D)
                      : const Color(0xFF9A9AA8),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: isCopied ? Colors.white : const Color(0xFF3A3A42),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isCopied
                      ? Colors.white.withValues(alpha: 0.12)
                      : const Color(0xFFF4F4F6),
                ),
                child: Text(
                  link,
                  style: TextStyle(
                    fontSize: 12,
                    color: isCopied
                        ? Colors.white.withValues(alpha: 0.72)
                        : const Color(0xFF7B7B88),
                    height: 1.45,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              FilledButton.icon(
                onPressed: onCopy,
                style: FilledButton.styleFrom(
                  backgroundColor: isCopied
                      ? const Color(0xFF5AAA90)
                      : const Color(0xFFE84A7F),
                ),
                icon: Icon(isCopied ? Icons.check : Icons.copy, size: 18),
                label: Text(isCopied ? 'コピー完了' : 'リンクをコピー'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

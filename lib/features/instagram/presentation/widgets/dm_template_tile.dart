import 'package:decocom_memo_flutter/features/instagram/domain/instagram_models.dart';
import 'package:flutter/material.dart';

class DmTemplateTile extends StatelessWidget {
  const DmTemplateTile({
    required this.template,
    required this.expanded,
    required this.isCopied,
    required this.previewText,
    required this.onTapHeader,
    required this.onCopy,
    super.key,
  });

  final DmTemplate template;
  final bool expanded;
  final bool isCopied;
  final String previewText;
  final VoidCallback onTapHeader;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final baseText = isCopied ? Colors.white : const Color(0xFF3A3A42);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: isCopied ? const Color(0xFF3A3A42) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE8E8EC)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTapHeader,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: <Widget>[
                  Text(template.icon, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      template.title,
                      style: TextStyle(
                        color: baseText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 180),
                    turns: expanded ? 0.5 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: isCopied ? Colors.white : const Color(0xFF9A9AA8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: onCopy,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(70, 32),
                      backgroundColor: isCopied
                          ? const Color(0xFF5AAA90)
                          : const Color(0x33FF6B9D),
                      foregroundColor: isCopied
                          ? Colors.white
                          : const Color(0xFFE84A7F),
                    ),
                    child: Text(
                      isCopied ? 'Done' : 'コピー',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            if (expanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        previewText,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.55,
                          color: Color(0xFF6A6A78),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FilledButton(
                      onPressed: onCopy,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: const Color(0xFFE84A7F),
                      ),
                      child: const Text('この内容をコピー'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

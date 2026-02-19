import 'package:decocom_memo_flutter/features/instagram/domain/instagram_models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OfficialHashtagSection extends StatelessWidget {
  const OfficialHashtagSection({
    required this.hashtags,
    super.key,
  });

  final List<OfficialHashtag> hashtags;

  @override
  Widget build(BuildContext context) {
    if (hashtags.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              '確認したいハッシュタグ',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: hashtags
                .map(
                  (OfficialHashtag h) => _HashtagChip(
                    tag: h.tag,
                    exploreUrl: h.exploreUrl,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _HashtagChip extends StatelessWidget {
  const _HashtagChip({
    required this.tag,
    required this.exploreUrl,
  });

  final String tag;
  final String exploreUrl;

  Future<void> _openExplore(BuildContext context) async {
    final uri = Uri.parse(exploreUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('リンクを開けませんでした'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _openExplore(context),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE8E8EC)),
            color: Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                tag,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3A3A42),
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.open_in_new,
                size: 14,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:decocom_memo_flutter/features/instagram/application/instagram_state.dart';
import 'package:decocom_memo_flutter/features/instagram/data/instagram_local_data.dart';
import 'package:decocom_memo_flutter/features/instagram/domain/instagram_models.dart';
import 'package:decocom_memo_flutter/features/instagram/presentation/widgets/account_tabs.dart';
import 'package:decocom_memo_flutter/features/instagram/presentation/widgets/dm_template_tile.dart';
import 'package:decocom_memo_flutter/features/instagram/presentation/widgets/official_hashtag_section.dart';
import 'package:decocom_memo_flutter/features/instagram/presentation/widgets/story_link_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InstagramPage extends ConsumerWidget {
  const InstagramPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ui = ref.watch(instagramUiProvider);
    final groupedTemplates = ref.watch(groupedTemplatesProvider);
    final deadline = ref.watch(deadlineTextProvider);
    final hashtags = ref.watch(currentOfficialHashtagsProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: AccountTabs(
                activeAccount: ui.activeAccount,
                onTap: (InstagramAccount account) => ref
                    .read(instagramUiProvider.notifier)
                    .selectAccount(account),
              ),
            ),
            SliverToBoxAdapter(
              child: OfficialHashtagSection(hashtags: hashtags),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
                child: SegmentedButton<InstagramTab>(
                  showSelectedIcon: false,
                  segments: const <ButtonSegment<InstagramTab>>[
                    ButtonSegment<InstagramTab>(
                      value: InstagramTab.story,
                      icon: Icon(Icons.location_pin, size: 18),
                      label: Text('ストーリー'),
                    ),
                    ButtonSegment<InstagramTab>(
                      value: InstagramTab.dm,
                      icon: Icon(Icons.chat_bubble, size: 18),
                      label: Text('DMテンプレ'),
                    ),
                  ],
                  selected: <InstagramTab>{ui.activeTab},
                  onSelectionChanged: (Set<InstagramTab> values) {
                    ref
                        .read(instagramUiProvider.notifier)
                        .selectTab(values.first);
                  },
                ),
              ),
            ),
            if (ui.activeTab == InstagramTab.story)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: ui.activeAccount == InstagramAccount.jp
                      ? Column(
                          children: <Widget>[
                            StoryLinkCard(
                              title: 'JP Instagram ストーリー用リンク',
                              link: storyLinks[InstagramAccount.jp] ?? '',
                              isCopied: ui.copiedId == 'story-jp',
                              onCopy: () => _copyAndNotify(
                                context: context,
                                ref: ref,
                                copiedId: 'story-jp',
                                sourceText:
                                    storyLinks[InstagramAccount.jp] ?? '',
                                deadline: deadline,
                              ),
                            ),
                            const SizedBox(height: 16),
                            StoryLinkCard(
                              title: 'JP Twitter（X）用リンク',
                              link: jpTwitterLink,
                              isCopied: ui.copiedId == 'jp-twitter-link',
                              onCopy: () => _copyAndNotify(
                                context: context,
                                ref: ref,
                                copiedId: 'jp-twitter-link',
                                sourceText: jpTwitterLink,
                                deadline: deadline,
                              ),
                            ),
                          ],
                        )
                      : StoryLinkCard(
                          title: '${ui.activeAccount.label} ストーリー用リンク',
                          link: storyLinks[ui.activeAccount] ?? '',
                          isCopied:
                              ui.copiedId == 'story-${ui.activeAccount.name}',
                          onCopy: () => _copyAndNotify(
                            context: context,
                            ref: ref,
                            copiedId: 'story-${ui.activeAccount.name}',
                            sourceText: storyLinks[ui.activeAccount] ?? '',
                            deadline: deadline,
                          ),
                        ),
                ),
              ),
            if (ui.activeTab == InstagramTab.dm)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    for (final entry in groupedTemplates.entries) ...<Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, left: 4),
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                            color: Color(0xFF9A9AA8),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      for (final template in entry.value)
                        DmTemplateTile(
                          template: template,
                          expanded: ui.expandedId == template.id,
                          isCopied: ui.copiedId == template.id,
                          previewText: template.text.replaceAll(
                            '{deadline}',
                            deadline,
                          ),
                          onTapHeader: () => ref
                              .read(instagramUiProvider.notifier)
                              .toggleExpanded(template.id),
                          onCopy: () => _copyAndNotify(
                            context: context,
                            ref: ref,
                            copiedId: template.id,
                            sourceText: template.text,
                            deadline: deadline,
                          ),
                        ),
                      const SizedBox(height: 10),
                    ],
                    Container(
                      margin: const EdgeInsets.only(top: 6, bottom: 28),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEEF2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFFFD7E3)),
                      ),
                      child: Row(
                        children: <Widget>[
                          const Text('📅', style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '自動挿入される締切日',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                deadline,
                                style: const TextStyle(
                                  color: Color(0xFFE84A7F),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE8E8EC))),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(radius: 4, backgroundColor: Color(0xFFFF6B9D)),
                SizedBox(width: 8),
                Text(
                  'Instagram',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Text(
              'More coming soon',
              style: TextStyle(color: Color(0xFF9A9AA8), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copyAndNotify({
    required BuildContext context,
    required WidgetRef ref,
    required String copiedId,
    required String sourceText,
    required String deadline,
  }) async {
    final text = sourceText.replaceAll('{deadline}', deadline);
    await Clipboard.setData(ClipboardData(text: text));
    ref.read(instagramUiProvider.notifier).setCopied(copiedId);
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('コピーしました'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 1200),
      ),
    );
  }
}

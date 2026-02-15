import 'dart:async';

import 'package:decocom_memo_flutter/features/instagram/data/instagram_local_data.dart';
import 'package:decocom_memo_flutter/features/instagram/domain/instagram_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InstagramUiState {
  const InstagramUiState({
    required this.activeAccount,
    required this.activeTab,
    this.copiedId,
    this.expandedId,
  });

  final InstagramAccount activeAccount;
  final InstagramTab activeTab;
  final String? copiedId;
  final String? expandedId;

  InstagramUiState copyWith({
    InstagramAccount? activeAccount,
    InstagramTab? activeTab,
    String? copiedId,
    bool clearCopiedId = false,
    String? expandedId,
    bool clearExpandedId = false,
  }) {
    return InstagramUiState(
      activeAccount: activeAccount ?? this.activeAccount,
      activeTab: activeTab ?? this.activeTab,
      copiedId: clearCopiedId ? null : (copiedId ?? this.copiedId),
      expandedId: clearExpandedId ? null : (expandedId ?? this.expandedId),
    );
  }
}

class InstagramUiNotifier extends Notifier<InstagramUiState> {
  Timer? _copiedTimer;

  @override
  InstagramUiState build() {
    ref.onDispose(() => _copiedTimer?.cancel());
    return const InstagramUiState(
      activeAccount: InstagramAccount.official,
      activeTab: InstagramTab.story,
    );
  }

  void selectAccount(InstagramAccount account) {
    state = state.copyWith(activeAccount: account, clearExpandedId: true);
  }

  void selectTab(InstagramTab tab) {
    state = state.copyWith(activeTab: tab, clearExpandedId: true);
  }

  void toggleExpanded(String templateId) {
    if (state.expandedId == templateId) {
      state = state.copyWith(clearExpandedId: true);
      return;
    }
    state = state.copyWith(expandedId: templateId);
  }

  void setCopied(String id) {
    _copiedTimer?.cancel();
    state = state.copyWith(copiedId: id);
    _copiedTimer = Timer(const Duration(milliseconds: 1500), () {
      if (!ref.mounted) {
        return;
      }
      state = state.copyWith(clearCopiedId: true);
    });
  }
}

final instagramUiProvider =
    NotifierProvider<InstagramUiNotifier, InstagramUiState>(
      InstagramUiNotifier.new,
    );

final deadlineTextProvider = Provider<String>((ref) {
  final date = DateTime.now().add(const Duration(days: 14));
  return '${date.month}月${date.day}日';
});

final currentTemplatesProvider = Provider<List<DmTemplate>>((ref) {
  final state = ref.watch(instagramUiProvider);
  final accountItems = accountTemplates[state.activeAccount] ?? <DmTemplate>[];
  return <DmTemplate>[...accountItems, ...commonTemplates];
});

final groupedTemplatesProvider = Provider<Map<String, List<DmTemplate>>>((ref) {
  final items = ref.watch(currentTemplatesProvider);
  final map = <String, List<DmTemplate>>{};
  for (final item in items) {
    map.putIfAbsent(item.category, () => <DmTemplate>[]).add(item);
  }
  return map;
});

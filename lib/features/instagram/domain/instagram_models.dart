enum InstagramAccount { official, days, jp }

extension InstagramAccountX on InstagramAccount {
  String get label => switch (this) {
    InstagramAccount.official => 'Official',
    InstagramAccount.days => 'Days',
    InstagramAccount.jp => 'JP',
  };

  String get subLabel => switch (this) {
    InstagramAccount.official => '@decocom_official',
    InstagramAccount.days => '@decocom_days',
    InstagramAccount.jp => '@decocom_jp',
  };
}

enum InstagramTab { story, dm }

/// 常に確認したいオフィシャルハッシュタグ（アカウントごと）
class OfficialHashtag {
  const OfficialHashtag({
    required this.tag,
    required this.exploreUrl,
  });

  /// 表示用（例: #snowmanのある生活）
  final String tag;
  /// Instagram キーワード検索URL（例: https://www.instagram.com/explore/search/keyword/?q=%23...）
  final String exploreUrl;
}

class DmTemplate {
  const DmTemplate({
    required this.id,
    required this.category,
    required this.title,
    required this.icon,
    required this.text,
  });

  final String id;
  final String category;
  final String title;
  final String icon;
  final String text;
}

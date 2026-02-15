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

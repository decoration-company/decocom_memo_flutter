import 'package:decocom_memo_flutter/features/instagram/presentation/pages/instagram_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/instagram',
  routes: <RouteBase>[
    GoRoute(path: '/instagram', builder: (_, _) => const InstagramPage()),
  ],
);

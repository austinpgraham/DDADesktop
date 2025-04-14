import 'package:dda_desktop/presentation/auth/login.dart';
import 'package:dda_desktop/presentation/loading.dart';
import 'package:go_router/go_router.dart';

final GoRouter rootRouter = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(path: "/loading", builder: (context, state) => LoadingPage()),
    GoRoute(path: "/login", builder: (context, state) => LoginPage()),
  ],
);

import 'package:front_proyectogrado/views/administrador/admin_page.dart';
import 'package:front_proyectogrado/views/administrador/registerdoctor_page.dart';
import 'package:front_proyectogrado/views/auth/login_page.dart';
import 'package:front_proyectogrado/views/auth/register_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(), // Usa LogingPage
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(), // Usa RegisterPage
    ),
    GoRoute(
      path: '/registermedico',
      builder: (context, state) => const RegisterDoctorPage(), // Usa RegisterDoctorPage
    ),
  ]
);
import 'package:front_proyectogrado/views/administrador/admin_page.dart';
import 'package:front_proyectogrado/views/administrador/registerdoctor_page.dart';
import 'package:front_proyectogrado/views/auth/login_page.dart';
import 'package:front_proyectogrado/views/auth/register_page.dart';
import 'package:front_proyectogrado/views/especialidad/especialidad_create_view.dart';
import 'package:front_proyectogrado/views/especialidad/especialidad_edit_view.dart';
import 'package:front_proyectogrado/views/especialidad/especialidad_list_view.dart';
import 'package:front_proyectogrado/views/paciente/home_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => const LoginPage(), // Usa HomePage
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(), // Usa RegisterPage
    ),
    GoRoute(
      path: '/registermedico',
      builder:
          (context, state) =>
              const RegisterDoctorPage(), // Usa RegisterDoctorPage
    ),
    GoRoute(
      path: '/AdminPage',
      name: 'AdminPage',
      builder: (context, state) => const AdminPage(), // Usa AdminPage
    ),

    //!Ruta para editar de un establecimiento
    GoRoute(
      path: '/especialidades/edit/:id',
      builder: (context, state) {
        //*se captura el id del establecimiento
        final id = int.parse(state.pathParameters['id']!);
        return EspecialidadEditView(id: id);
      },
    ),
    //!Ruta para crear un nuevo establecimiento
    GoRoute(
      path: '/especialidades/create',
      builder: (context, state) => const EspecialidadCreateView(),
    ),
    GoRoute(
      path: '/especialidades',
      builder: (context, state) => const EspecialidadesListView(),
    ),
    
    GoRoute(
      path: '/home_view',
      name: 'home_view',
      builder: (context, state) => const HomePage(),
    ), // Usa AdminPage
  ],
);

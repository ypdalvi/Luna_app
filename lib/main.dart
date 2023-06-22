import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/features/admin/screens/admin_home_screen.dart';
import 'package:luna/features/auth/screens/login_screen.dart';
import 'package:luna/features/health/controller/health_controller.dart';
import 'package:luna/features/home/screens/home_screen.dart';
import 'package:luna/proxy_screen.dart';
import 'package:luna/router.dart';
import 'package:luna/theme/pallete.dart';
import 'core/common/error_text.dart';
import 'core/common/loader.dart';
import 'features/auth/controller/auth_controller.dart';
import 'firebase_options.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luna',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
        appBarTheme: AppBarTheme(
          color: Pallete.darkObjColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              ref.read(userModelProvider.notifier).update((state) => user);
              if (user != null) {
                return const ProxyScreen();
              }
              return const LoginScreen();
            },
            error: (err, trace) {
              return ErrorText(
                error: err.toString(),
              );
            },
            loading: () => const Loader(),
          ),
    );
  }
}

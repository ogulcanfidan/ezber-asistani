import 'package:flutter/material.dart';

import 'app_state.dart';
import 'l10n/app_localizations.dart';
import 'screens/library_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final state = await AppState.load();
  runApp(EzberApp(state: state));
}

class EzberApp extends StatelessWidget {
  const EzberApp({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF5B3E96);
    return AppScope(
      state: state,
      child: ValueListenableBuilder<Locale?>(
        valueListenable: state.locale,
        builder: (context, locale, _) => MaterialApp(
          onGenerateTitle: (context) => L.of(context).appTitle,
          debugShowCheckedModeBanner: false,
          locale: locale,
          supportedLocales: L.supportedLocales,
          localizationsDelegates: L.localizationsDelegates,
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: seed)),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
          ),
          home: const LibraryScreen(),
        ),
      ),
    );
  }
}

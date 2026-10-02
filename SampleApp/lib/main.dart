import 'package:flutter/material.dart';
import 'package:entrust_idvsdk_flutter/entrust_idvsdk_flutter.dart';

// For Studio flows, use the SDK token generated during the workflow creation
// process. The workflow run ID is embedded in the Studio token.
const String studioToken = '<Your Studio token>';

// For 'classic' sessions not yet migrated to Workflow Studio, create an SDK
// token for this applicant in your backend and use it here.
const String sdkToken = '<Your SDK token>';

// Language keys: https://sdk.onfido.com/capture/i18n/index.json
// Custom translations for a module and language:
//   https://sdk.onfido.com/capture/i18n/welcome/en_US.min.json
// Common translations for a language:
//   https://sdk.onfido.com/capture/i18n/common/en_US.min.json
const Localisation customLocalisation = Localisation(
  language: 'en_US',
  allowedLanguages: ['en_US'],
  overrides: {
    'en_US': {
      'welcome.title': 'Custom welcome title',
      'welcome.button.default': 'Custom button text',
    },
  },
);

const IdvTheme customTheme = IdvTheme(
  mode: IdvThemeMode.light,
  branding: Branding(
    text: 'Brand Name',
    // URL to a publicly accessible SVG image
    logo: 'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.svg',
  ),
  lightColors: SdkColors(backgroundColorOverlay: '#10598A85'),
  darkColors: SdkColors(backgroundColorOverlay: '#10598A85'),
);

const Configuration configuration = Configuration(
  theme: customTheme,
  localisation: customLocalisation,
);

const StudioParameters studioFlowParameters = StudioParameters(
  sdkToken: studioToken,
  configuration: configuration,
);

// 'Classic' flow example (unused)
// ignore: unused_element
final ClassicParameters classicFlowParameters = ClassicParameters(
  sdkToken: sdkToken,
  steps: [Welcome(), Document(), FaceMotion()],
  configuration: configuration,
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IDV SDK Flutter Sample',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final EntrustIdv _idv;

  @override
  void initState() {
    super.initState();
    _idv = EntrustIdv(
      callbacks: Callbacks(
        onComplete: (result) {
          debugPrint('The onComplete callback has been called. Received: $result');
          // Finish or navigate away
        },
        onError: (error) {
          debugPrint('The onError callback has been called with: ${error.message}');
          if (!mounted) return;
          showDialog<void>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('An error occurred'),
              content: Text(error.message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Finish or navigate away
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        onUserExit: (userAction) {
          debugPrint('The onUserExit has been called with userAction: ${userAction.value}');
          // Finish or navigate away
        },
      ),
    );
  }

  void _launchSdk() {
    _idv.start(studioFlowParameters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: _launchSdk,
            child: const Text('Launch SDK'),
          ),
        ),
      ),
    );
  }
}

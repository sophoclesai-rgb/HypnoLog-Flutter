import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart' as fo;
import 'services/revenuecat_service.dart';

class Bootstrap {
  static Future<void> initialize() async {
    await Firebase.initializeApp(options: fo.DefaultFirebaseOptions.currentPlatform);
    await RevenueCatService.configure();
  }
}
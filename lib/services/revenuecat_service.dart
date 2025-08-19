import 'dart:io';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../config/revenuecat_config.dart';

class RevenueCatService {
  static Future<void> configure() async {
    final conf = PurchasesConfiguration(
      Platform.isAndroid ? RevenueCatConfig.publicSdkKeyAndroid : RevenueCatConfig.publicSdkKeyIos,
    );
    await Purchases.configure(conf);
  }
}
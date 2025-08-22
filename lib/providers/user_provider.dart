import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserType { 
  free,                 // Üye Tipi 1 - Free
  startTrial,           // Üye Tipi 2 - Start Trial (3 günlük deneme)  
  weeklyPremiumTrial,   // Üye Tipi 2.1 - Weekly Premium (trial sonrası)
  monthlyPremium,       // Üye Tipi 3 - Monthly Premium
  yearlyPremium,        // Üye Tipi 3 - Yearly Premium
}

// Gmail adresleri ve üyelik tipleri (Gerçek kullanıcı hesapları)
const Map<String, UserType> realGmailUserTypes = {
  'oguzbahadir@gmail.com': UserType.free,              // Üye Tipi 1 - Free (sınırlı haklar)
  'scifivetech@gmail.com': UserType.startTrial,        // Üye Tipi 2 - Start Trial (3 günlük deneme)
  'bahadirafist@gmail.com': UserType.monthlyPremium,   // Üye Tipi 3 - Monthly Premium
  'scifivedev@gmail.com': UserType.yearlyPremium,      // Üye Tipi 3 - Yearly Premium
};

// Kullanıcı limitleri
class UserLimits {
  final int dreamInterpretations;    // Rüya yorumu
  final int dreamVisualizations;     // Görsel üretme  
  final int dreamVideos;            // Video üretme
  final bool unlimitedDreamWriting; // Sınırsız metin yazma
  final bool allPremiumFeatures;    // Tüm premium özellikler

  const UserLimits({
    this.dreamInterpretations = 0,
    this.dreamVisualizations = 0, 
    this.dreamVideos = 0,
    this.unlimitedDreamWriting = true,
    this.allPremiumFeatures = false,
  });
}

// Üye tipi limitleri
const Map<UserType, UserLimits> userTypeLimits = {
  UserType.free: UserLimits(
    dreamInterpretations: 1,
    dreamVisualizations: 1, 
    dreamVideos: 1,
    unlimitedDreamWriting: true,
    allPremiumFeatures: false,
  ),
  UserType.startTrial: UserLimits(
    dreamInterpretations: 999,  // 3 gün unlimited
    dreamVisualizations: 999,
    dreamVideos: 999,
    unlimitedDreamWriting: true,
    allPremiumFeatures: true,
  ),
  UserType.weeklyPremiumTrial: UserLimits(
    dreamInterpretations: 999,  // Premium unlimited
    dreamVisualizations: 999,
    dreamVideos: 999,
    unlimitedDreamWriting: true,
    allPremiumFeatures: true,
  ),
  UserType.monthlyPremium: UserLimits(
    dreamInterpretations: 999,  // Premium unlimited
    dreamVisualizations: 999,
    dreamVideos: 999,
    unlimitedDreamWriting: true,
    allPremiumFeatures: true,
  ),
  UserType.yearlyPremium: UserLimits(
    dreamInterpretations: 999,  // Premium unlimited
    dreamVisualizations: 999,
    dreamVideos: 999,
    unlimitedDreamWriting: true,
    allPremiumFeatures: true,
  ),
};

class UserState {
  final UserType userType;
  final String? email;
  final bool isLoading;
  
  // Kullanıcının mevcut kullanım sayıları (Free user tracking için)
  final int usedDreamInterpretations;
  final int usedDreamVisualizations;
  final int usedDreamVideos;
  final DateTime? trialStartDate; // Trial başlangıç tarihi

  const UserState({
    required this.userType,
    this.email,
    this.isLoading = false,
    this.usedDreamInterpretations = 0,
    this.usedDreamVisualizations = 0,
    this.usedDreamVideos = 0,
    this.trialStartDate,
  });

  UserState copyWith({
    UserType? userType,
    String? email,
    bool? isLoading,
    int? usedDreamInterpretations,
    int? usedDreamVisualizations,
    int? usedDreamVideos,
    DateTime? trialStartDate,
  }) {
    return UserState(
      userType: userType ?? this.userType,
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      usedDreamInterpretations: usedDreamInterpretations ?? this.usedDreamInterpretations,
      usedDreamVisualizations: usedDreamVisualizations ?? this.usedDreamVisualizations,
      usedDreamVideos: usedDreamVideos ?? this.usedDreamVideos,
      trialStartDate: trialStartDate ?? this.trialStartDate,
    );
  }

  // Kullanıcının mevcut limitlerini al
  UserLimits get currentLimits => userTypeLimits[userType]!;

  // Kalan hakları hesapla
  int get remainingInterpretations => 
    currentLimits.dreamInterpretations == 999 ? 999 : 
    (currentLimits.dreamInterpretations - usedDreamInterpretations).clamp(0, 999);
    
  int get remainingVisualizations => 
    currentLimits.dreamVisualizations == 999 ? 999 : 
    (currentLimits.dreamVisualizations - usedDreamVisualizations).clamp(0, 999);
    
  int get remainingVideos => 
    currentLimits.dreamVideos == 999 ? 999 : 
    (currentLimits.dreamVideos - usedDreamVideos).clamp(0, 999);

  // Trial süresi kaldı mı?
  bool get isTrialActive {
    if (userType != UserType.startTrial || trialStartDate == null) return false;
    final daysPassed = DateTime.now().difference(trialStartDate!).inDays;
    return daysPassed < 3;
  }

  // Trial süresi doldu mu?
  bool get isTrialExpired {
    if (userType != UserType.startTrial || trialStartDate == null) return false;
    final daysPassed = DateTime.now().difference(trialStartDate!).inDays;
    return daysPassed >= 3;
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState(userType: UserType.free));

  // Gmail ile giriş yap - otomatik üyelik tipi belirleme
  void loginWithGmail(String gmailEmail) {
    final userType = realGmailUserTypes[gmailEmail.toLowerCase()] ?? UserType.free;
    final trialStartDate = userType == UserType.startTrial ? DateTime.now() : null;
    
    state = state.copyWith(
      userType: userType,
      email: gmailEmail,
      isLoading: false,
      trialStartDate: trialStartDate,
      // Reset usage for new login
      usedDreamInterpretations: 0,
      usedDreamVisualizations: 0, 
      usedDreamVideos: 0,
    );
  }

  // Çıkış yap - Free user'a döner
  void logout() {
    state = const UserState(userType: UserType.free);
  }

  // Rüya yorumu kullan (Free user için limit kontrolü)
  bool useDreamInterpretation() {
    if (state.remainingInterpretations <= 0) return false;
    
    state = state.copyWith(
      usedDreamInterpretations: state.usedDreamInterpretations + 1,
    );
    return true;
  }

  // Görsel üretme kullan (Free user için limit kontrolü)
  bool useDreamVisualization() {
    if (state.remainingVisualizations <= 0) return false;
    
    state = state.copyWith(
      usedDreamVisualizations: state.usedDreamVisualizations + 1,
    );
    return true;
  }

  // Video üretme kullan (Free user için limit kontrolü)
  bool useDreamVideo() {
    if (state.remainingVideos <= 0) return false;
    
    state = state.copyWith(
      usedDreamVideos: state.usedDreamVideos + 1,
    );
    return true;
  }

  // Trial'dan premium'a geçiş
  void upgradeTrialToWeeklyPremium() {
    if (state.userType == UserType.startTrial) {
      state = state.copyWith(
        userType: UserType.weeklyPremiumTrial,
        trialStartDate: null,
      );
    }
  }

  // Manuel premium upgrade (paywall'dan)
  void upgradeToMonthlyPremium() {
    state = state.copyWith(userType: UserType.monthlyPremium);
  }

  void upgradeToYearlyPremium() {
    state = state.copyWith(userType: UserType.yearlyPremium);
  }

  // Trial süresi dolunca Free'ye dönüş
  void downgradeExpiredTrialToFree() {
    if (state.isTrialExpired) {
      state = state.copyWith(
        userType: UserType.free,
        trialStartDate: null,
      );
    }
  }

  // Upgrade badge gösterilsin mi?
  bool get shouldShowUpgradeBadge => state.userType == UserType.free;
  
  // Premium özelliklere erişim var mı?
  bool get hasPremiumAccess => [
    UserType.startTrial, 
    UserType.weeklyPremiumTrial,
    UserType.monthlyPremium, 
    UserType.yearlyPremium
  ].contains(state.userType) && (state.userType != UserType.startTrial || state.isTrialActive);

  // Debug bilgisi
  String get currentUserInfo => 
      'Gmail: ${state.email ?? "Not logged in"} | Type: ${state.userType.name}';

  // Detailed usage info
  String get usageInfo => '''
Interpretations: ${state.usedDreamInterpretations}/${state.currentLimits.dreamInterpretations == 999 ? "∞" : state.currentLimits.dreamInterpretations}
Visualizations: ${state.usedDreamVisualizations}/${state.currentLimits.dreamVisualizations == 999 ? "∞" : state.currentLimits.dreamVisualizations}  
Videos: ${state.usedDreamVideos}/${state.currentLimits.dreamVideos == 999 ? "∞" : state.currentLimits.dreamVideos}
${state.userType == UserType.startTrial ? "Trial: ${state.isTrialActive ? "Active" : "Expired"}" : ""}''';
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});

// Helper provider for checking if user should see upgrade badge
final shouldShowUpgradeBadgeProvider = Provider<bool>((ref) {
  final userState = ref.watch(userProvider);
  return userState.userType == UserType.free;
});
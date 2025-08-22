import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserType { free, startTrial, premium }

// Test e-postaları ve üyelik tipleri
const Map<String, UserType> testEmailUserTypes = {
  'free@test.com': UserType.free,           // Üye Tipi 1 - Free (Upgrade badge görür)
  'trial@test.com': UserType.startTrial,    // Üye Tipi 2 - Start Trial (3 günlük deneme)
  'premium@test.com': UserType.premium,     // Üye Tipi 3 - Premium (İlk kez premium yapanlar)
  'vip@test.com': UserType.premium,         // VIP Premium user (upgrade badge görmez)
};

class UserState {
  final UserType userType;
  final String? email;
  final bool isLoading;

  const UserState({
    required this.userType,
    this.email,
    this.isLoading = false,
  });

  UserState copyWith({
    UserType? userType,
    String? email,
    bool? isLoading,
  }) {
    return UserState(
      userType: userType ?? this.userType,
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState(userType: UserType.free));

  // E-posta ile giriş yap - otomatik üyelik tipi belirleme
  void loginWithEmail(String email) {
    final userType = testEmailUserTypes[email.toLowerCase()] ?? UserType.free;
    state = state.copyWith(
      userType: userType,
      email: email,
      isLoading: false,
    );
  }

  // Çıkış yap - Free user'a döner
  void logout() {
    state = const UserState(userType: UserType.free);
  }

  void setUserType(UserType userType) {
    state = state.copyWith(userType: userType);
  }

  void upgradeToStartTrial() {
    state = state.copyWith(userType: UserType.startTrial);
  }

  void upgradeToPremium() {
    state = state.copyWith(userType: UserType.premium);
  }

  bool get shouldShowUpgradeBadge => state.userType == UserType.free;
  
  // Debug için kullanılacak
  String get currentUserInfo => 
      'Email: ${state.email ?? "Not logged in"} | Type: ${state.userType.name}';
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});

// Helper provider for checking if user should see upgrade badge
final shouldShowUpgradeBadgeProvider = Provider<bool>((ref) {
  final userState = ref.watch(userProvider);
  return userState.userType == UserType.free;
});
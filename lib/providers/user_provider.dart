import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserType { free, startTrial, premium }

class UserState {
  final UserType userType;
  final bool isLoading;

  const UserState({
    required this.userType,
    this.isLoading = false,
  });

  UserState copyWith({
    UserType? userType,
    bool? isLoading,
  }) {
    return UserState(
      userType: userType ?? this.userType,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState(userType: UserType.free));

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
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});

// Helper provider for checking if user should see upgrade badge
final shouldShowUpgradeBadgeProvider = Provider<bool>((ref) {
  final userState = ref.watch(userProvider);
  return userState.userType == UserType.free;
});
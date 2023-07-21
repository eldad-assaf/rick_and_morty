part of 'app_bloc.dart';

// AppStatus enum represents the possible states of the app.
enum AppStatus {
  authenticated,
  unauthenticated,
}
// AppState class holds the state of the app, including the user's authentication status and user data.
final class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });
  // AppState constructor for an authenticated state with user data.
  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);
      
  // AppState constructor for an unauthenticated state without user data.
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}

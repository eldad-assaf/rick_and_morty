part of 'app_bloc.dart';

// AppEvent is a sealed class that represents the events that can occur in the app.
// Other events can be added in the future, but for now, we have AppLogoutRequested and _AppUserChanged events.
sealed class AppEvent {
  const AppEvent();
}
// AppLogoutRequested event is dispatched when the user initiates a logout request.
final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}
// _AppUserChanged event is dispatched when the user authentication status changes.
final class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);

  final User user;
}

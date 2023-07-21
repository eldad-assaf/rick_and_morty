import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

// AppBloc is a business logic component responsible for managing app state based on events and the current state.
class AppBloc extends Bloc<AppEvent, AppState> {
  // The constructor for AppBloc.
  // It takes an AuthenticationRepository as a required parameter for user authentication operations.
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    // Register event handlers for specific events.
    on<_AppUserChanged>(_onUserChanged);

    on<AppLogoutRequested>(_onLogoutRequested);
    // Subscribe to changes in the user authentication status using the provided repository's user stream.
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(_AppUserChanged(user)),
    );
  }
  // The AuthenticationRepository instance used for authentication operations.
  final AuthenticationRepository _authenticationRepository;
  // StreamSubscription to keep track of changes in the user authentication status.
  late final StreamSubscription<User> _userSubscription;

  // Event handler for the _AppUserChanged event.
  // It updates the app state based on the new user authentication status.
  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  // Event handler for the AppLogoutRequested event.
  // It initiates the logout process by calling the logout method from the AuthenticationRepository.
  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    // Clean up resources by canceling the user subscription.

    _userSubscription.cancel();
    return super.close();
  }
}

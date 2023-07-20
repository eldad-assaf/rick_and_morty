import 'package:flutter/widgets.dart';
import 'package:rick_and_morty/views/screens/onboarding/pages/onboarding.dart';
import '../signup/bloc/app_bloc.dart';
import '../views/screens/main_screen.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [Onboarding.page()];
  }
}

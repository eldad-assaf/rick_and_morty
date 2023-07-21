import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/routes/routes.dart';
import 'package:rick_and_morty/signup/bloc/app_bloc.dart';
import 'package:rick_and_morty/state/blocs/all_characters_bloc/all_characters_bloc.dart';
import 'package:rick_and_morty/state/blocs/favourites_blocs/favourites_bloc.dart';
import 'package:rick_and_morty/state/blocs/filter_bloc/bloc/filter_bloc.dart';
import 'package:rick_and_morty/state/blocs/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:authentication_repository/authentication_repository.dart';

import 'common/utils/constants.dart';

class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log(change.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(transition.toString());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await Firebase.initializeApp();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  runApp(RickAndMortyApp(
    authenticationRepository: authenticationRepository,
  ));
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;
  final AuthenticationRepository _authenticationRepository;

  static final defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
      brightness: Brightness.dark, primarySwatch: Colors.blue);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => CharacterRepository(dio: Dio()),
        ),
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<AppBloc>(
              create: (context) =>
                  AppBloc(authenticationRepository: _authenticationRepository),
            ),
            BlocProvider<FilterBloc>(
              create: (context) => FilterBloc(),
            ),
            BlocProvider<AllCharactersBloc>(
              create: (context) => AllCharactersBloc(
                  RepositoryProvider.of(context),
                  BlocProvider.of<FilterBloc>(context))
                ..add(LoadCharactersEvent()),
            ),
            BlocProvider<SearchBloc>(
              create: (context) => SearchBloc(RepositoryProvider.of(context)),
            ),
            BlocProvider<FavouritesBloc>(
              create: (context) => FavouritesBloc(),
            ),
          ],
          child: ScreenUtilInit(
            useInheritedMediaQuery: true,
            //390,844 is the designSize for iphone 13 pro
            designSize: const Size(390, 844),
            minTextAdapt: true,

            builder: (BuildContext context, Widget? child) {
              return DynamicColorBuilder(
                builder: (lightColorSceheme, darkColorscheme) {
                  return MaterialApp(
                      title: 'Rick and morty app',
                      theme: ThemeData(
                        scaffoldBackgroundColor: Appconst.kBkDark,
                        primarySwatch: Colors.blue,
                        useMaterial3: true,
                        colorScheme:
                            lightColorSceheme ?? defaultLightColorScheme,
                      ),
                      //initialRoute: '/',
                      // routes: {
                      //   '/': (context) => const Onboarding(),
                      // },

                      home: const MyFlowBuilder());
                },
              );
            },
          )),
    );
  }
}

class MyFlowBuilder extends StatefulWidget {
  const MyFlowBuilder({super.key});

  @override
  State<MyFlowBuilder> createState() => _MyFlowBuilderState();
}

class _MyFlowBuilderState extends State<MyFlowBuilder> {
  @override
  Widget build(BuildContext context) {
    var appStatus = context.select((AppBloc bloc) => bloc.state.status);
    return FlowBuilder<AppStatus>(
      state: appStatus,
      onGeneratePages: onGenerateAppViewPages,
    );
  }
}

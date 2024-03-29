import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/common/alert_dialog_model.dart';
import 'package:rick_and_morty/common/utils/constants.dart';
import 'package:rick_and_morty/views/screens/search_screen.dart';
import 'package:rick_and_morty/views/widgets/characters_list_grid_view.dart';
import 'package:rick_and_morty/views/widgets/filter_bottom_sheet.dart';
import '../../signup/bloc/app_bloc.dart';
import '../../state/blocs/all_characters_bloc/all_characters_bloc.dart';
import '../widgets/favourite_icon_with_count.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  Widget determineWidgetByState(AllCharacterState state, BuildContext context) {
    switch (state.runtimeType) {
      case LoadingCharactersState:
        return const Center(child: CircularProgressIndicator());
      case CharactersLoadedState:
        context.read<AllCharactersBloc>().add(ScrollToLastPosition());
        return CharactersListGridView(
          charactersResponse: state.charactersResponse!,
          isLoadingMore: context.read<AllCharactersBloc>().isLoadingMore,
          scrollController:
              context.read<AllCharactersBloc>().allCharactersScrollController,
        );
      case CharactersErrorState:
        return const Center(
          child: Text('Opps! Something went wrong :-('),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => showFilterModalBottomSheet(context),
              icon: Icon(
                Icons.filter_list,
                size: 24.sp,
              )),
          actions: [
            const FavouriteIconWithBadge(),
            IconButton(
              icon: Icon(
                Icons.search,
                size: 24.sp,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 24.sp,
                color: Appconst.kred,
              ),
              onPressed: () {
                const AlertDialogModel(
                        title: "The universe is basically an animal.",
                        buttons: {"Yes, Sign out": true, "Not now": false},
                        message: 'Are you leaving?')
                    .present(context)
                    .then((shouldSignOut) {
                  if (shouldSignOut == true) {
                    context.read<AppBloc>().add(const AppLogoutRequested());
                  }
                });
              },
            ),
          ],
        ),
        body: BlocBuilder<AllCharactersBloc, AllCharacterState>(
          builder: (context, state) {
            return determineWidgetByState(state, context);
          },
        ),
      ),
    );
  }
}

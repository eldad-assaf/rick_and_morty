import 'package:rick_and_morty/views/animations/lottie_animation.dart';
import 'package:rick_and_morty/views/animations/lottie_animation_view.dart';

class SearchAnimationView extends LottieAnimationView {
  const SearchAnimationView({super.key})
      : super(animation: LottieAnimation.search);
}

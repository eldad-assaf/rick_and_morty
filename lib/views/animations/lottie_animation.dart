enum LottieAnimation {
  search(name: 'search'),
  notFound(name: 'not_found');

  final String name;
  const LottieAnimation({
    required this.name,
  });
}

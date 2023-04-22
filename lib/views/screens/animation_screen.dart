import 'package:flutter/material.dart';
import 'package:rick_and_morty/views/animations/animated_prompt.dart';

class AnimationScreen extends StatelessWidget {
  const AnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: AnimatedPrompt(
            title: 'this is the title',
            subTitle: 'this is the subtitle',
            child: Icon(Icons.check)),
      ),
    );
  }
}

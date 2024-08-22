import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchLoadingIndicator extends StatelessWidget {
  const SearchLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FractionallySizedBox(
        widthFactor: 0.75,
        heightFactor: 0.75,
        child: Center(
          child: Lottie.asset(
            'assets/lottie/search-loading.json',
            fit: BoxFit.fill,
            repeat: true,
            animate: true,
          ),
        ),
      ),
    );
  }
}

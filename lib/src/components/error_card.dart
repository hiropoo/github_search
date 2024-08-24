import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:github_search/src/constants/app_sizes.dart';
import 'package:github_search/src/utils/extensions.dart';
import 'package:lottie/lottie.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Center(
                  child: Lottie.asset(
                    'assets/lottie/error-animation.json',
                    fit: BoxFit.fill,
                    repeat: false,
                    // animate: true,
                  ),
                ),
              ),
              Text(
                '${AppLocalizations.of(context)!.errorCode}: ${error.toString().extractErrorCode()}',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.errorDescription,
                textAlign: TextAlign.center,
              ),
              gapH32,
            ],
          ),
        ),
      ),
    );
  }
}

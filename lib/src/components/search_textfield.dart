import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_search/src/constants/app_sizes.dart';

class SearchTextfield extends HookWidget {
  const SearchTextfield({super.key, required this.controller, required this.onSubmitted});

  final TextEditingController controller;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    // テキストフィールドに入力されたテキストがあるかどうか
    final iconIsVisible = useState<bool>(false);

    // アニメーション用の幅係数
    final widthFactor = useState<double>(1.0);

    // FocusNodeを作成
    final focusNode = useFocusNode();

    // TextEditingControllerのリスナーを設定
    useEffect(() {
      void listener() {
        if (controller.text.isNotEmpty) {
          iconIsVisible.value = true;
        } else {
          iconIsVisible.value = false;
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    // FocusNodeのリスナーを設定
    useEffect(() {
      void focusListener() {
        widthFactor.value = focusNode.hasFocus ? 0.9 : 1.0;
        iconIsVisible.value = controller.text.isNotEmpty && focusNode.hasFocus;
      }

      focusNode.addListener(focusListener);
      return () => focusNode.removeListener(focusListener);
    }, [focusNode, controller.text]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: AnimatedFractionallySizedBox(
            alignment: Alignment.topLeft,
            widthFactor: widthFactor.value,
            duration: const Duration(milliseconds: 150),
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: TextField(
                focusNode: focusNode,
                controller: controller,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  // ヒントテキスト
                  hintText: AppLocalizations.of(context)!.searchHintText,

                  // 背景色
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  filled: true,

                  // ボーダー
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.p24),
                    borderSide: BorderSide.none,
                  ),

                  // アイコン
                  prefixIcon: const Icon(Icons.search),
                  // 入力されたテキストがあり、フォーカスがある場合はクリアボタンを表示
                  suffixIcon: iconIsVisible.value
                      ? IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed: () {
                            controller.clear();
                            // テキストフィールドを再度フォーカス
                            FocusScope.of(context).requestFocus(focusNode);
                          },
                        )
                      : null,
                ),
                onSubmitted: onSubmitted,
              ),
            ),
          ),
        ),
        focusNode.hasFocus
            ? TextButton(
                onPressed: () {
                  focusNode.unfocus(); // フォーカスを解除
                },
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

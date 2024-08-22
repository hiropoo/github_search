/// List extensions
/// 残りの要素を取得する拡張メソッド
extension ListTakeLast<T> on List<T> {
  List<T> takeLast(int n) {
    if (n <= 0) return [];
    return length <= n ? this : sublist(length - n);
  }
}

/// String extensions
extension ErrorCodeExtraction on String {
  String extractErrorCode() {
    final regex = RegExp(r'(\d{3})');
    final match = regex.firstMatch(this);

    if (match != null) {
      return match.group(1)!; // マッチしたエラーコードを返す
    } else {
      return 'Unknown error'; // エラーコードが見つからなかった場合
    }
  }
}

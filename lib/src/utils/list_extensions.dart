/// List extensions
/// 残りの要素を取得する拡張メソッド
extension ListTakeLast<T> on List<T> {
  List<T> takeLast(int n) {
    if (n <= 0) return [];
    return length <= n ? this : sublist(length - n);
  }
}

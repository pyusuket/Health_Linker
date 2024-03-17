// ページの読み込み時に現在のスクロール位置をセッションストレージに保存
window.addEventListener('beforeunload', function() {
  sessionStorage.setItem('scrollPosition', window.scrollY);
});
document.addEventListener('DOMContentLoaded', function() {
  // リダイレクト前に保存されたスクロール位置を取得
  var scrollPosition = sessionStorage.getItem('scrollPosition');

  // スクロール位置が保存されている場合は、その位置にスクロール
  if (scrollPosition) {
    window.scrollTo(0, scrollPosition);
    sessionStorage.removeItem('scrollPosition'); // スクロール位置を削除して次回のページ遷移時にリセット
  }
});
// 検索フォーム処理（ユーザーネームに一致する場合を絞り込み）
document.addEventListener('DOMContentLoaded', function() {
  const searchInput = document.querySelector('#search-field');
  const userList = document.querySelector('#user-list');
  const noResults = document.querySelector('#no-results');

  searchInput.addEventListener('keyup', function() {
    const searchTerm = searchInput.value.trim().toLowerCase();
    const users = userList.querySelectorAll('.bg-white');
    let foundMatch = false;

    users.forEach(user => {
      const userName = user.querySelector('.text-lg').textContent.toLowerCase();
      if (userName.includes(searchTerm)) {
        user.style.display = 'block';
        foundMatch = true;
      } else {
        user.style.display = 'none';
      }
    });

    if (!foundMatch) {
      noResults.style.display = 'block';
    } else {
      noResults.style.display = 'none';
    }
  });
});

// フォーム内を空にする
function clearSearchField() {
  document.querySelector("#search-field").value = "";
  location.reload();
}
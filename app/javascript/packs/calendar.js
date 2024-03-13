import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import jaLocale from '@fullcalendar/core/locales/ja';
import timeGridPlugin from '@fullcalendar/timegrid'

document.addEventListener('DOMContentLoaded', function() {
  //window.document.addEventListener('turbolinks:load', function() {
  console.log("calendar");
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, interactionPlugin, timeGridPlugin ],
    locale: jaLocale,
    initialView: 'timeGridWeek',
    headerToolbar: {
      left: 'prev,next,today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay' // user can switch between the two
    },
    events: '/user/events.json',
    eventClick: function(info) {
      // 登録されたイベントに対する処理
    alert('Event: ' + info.event.title);
    alert('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY);
    alert('View: ' + info.view.type);

    // change the border color just for fun
    info.el.style.borderColor = 'red';
  },
    dateClick: function(info){
            //クリックした日付の情報を取得
            const year  = info.date.getFullYear();
            const month = (info.date.getMonth() + 1);
            const day   = info.date.getDate();

            //ajaxでevents/newを着火させ、htmlを受け取ります
            $.ajax({
                type: 'GET',
                url:  '/events/new',
            }).done(function (res) {
                // 成功処理
                // 受け取ったhtmlをさっき追加したmodalのbodyの中に挿入します
                $('.modal-body').html(res);

                //フォームの年、月、日を自動入力
                $('#event_start_1i').val(year);
                $('#event_start_2i').val(month);
                $('#event_start_3i').val(day);

                $('#event_end_1i').val(year);
                $('#event_end_2i').val(month);
                $('#event_end_3i').val(day);

                //ここのidはevents/newのurlにアクセスするとhtmlがコードとして表示されるので、
                //開始時間と終了時間のフォームを表しているところのidを確認してもらうことが確実です

                $('#modal').fadeIn();

            }).fail(function (result) {
                // 失敗処理
                alert("failed");
            });
        },
    });
  calendar.render();
   document.getElementById('myForm').addEventListener('submit', function(event) {
    event.preventDefault(); // デフォルトのフォーム送信を停止

    // FormDataオブジェクトを作成
    var formData = new FormData(this);

    // Ajaxリクエストの送信
    fetch(this.action, {
      method: this.method,
      body: formData,
      headers: {
        'X-Requested-With': 'XMLHttpRequest' // リクエストがAjaxであることを示すヘッダーを追加
      }
    })
    .then(response => response.json()) // JSON形式でレスポンスを解析
    .then(data => {
      // 成功した場合の処理を記述
      closeModal(); 
      calendar.refetchEvents()
    })
    .catch(error => {
      console.error('Error:', error);
    });
  });
});


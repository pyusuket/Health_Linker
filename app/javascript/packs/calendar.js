import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import jaLocale from '@fullcalendar/core/locales/ja';
import timeGridPlugin from '@fullcalendar/timegrid'

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, interactionPlugin, timeGridPlugin ],
    locale: jaLocale,
    initialView: 'timeGridWeek',
    headerToolbar: {
      left: 'prev,next,today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay'
    },
    events: '/user/events.json',
  
  // 予定編集
  eventClick: function(info) {
      openModal(document.getElementById('editModal'));
    }
  });
  
    function openModal(modal) {
    var titleInput = modal.querySelector('#event_plan');
    var startInput = modal.querySelector('#event_start');
    var endInput = modal.querySelector('#event_end');
    
    titleInput.value = event.title;
    startInput.value = event.start;
    endInput.value = event.end;
  
    modal.style.display = "block";
  }

  function closeModal() {
    var modal = document.getElementById('editModal');
    modal.style.display = "none";
  }

  calendar.render();
  // 予定追加
  document.getElementById('myForm').addEventListener('submit', function(event) {
    event.preventDefault();

    var formData = new FormData(this);

    fetch(this.action, {
      method: this.method,
      body: formData,
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(response => response.json())
    .then(data => {
      closeModal(); 
      calendar.refetchEvents();
    })
    .catch(error => {
      console.error('Error:', error);
    });
  });

  calendar.setOption('dateClick', function(info) {
    const year  = info.date.getFullYear();
    const month = (info.date.getMonth() + 1);
    const day   = info.date.getDate();

    $.ajax({
      type: 'GET',
      url:  '/events/new',
    }).done(function (res) {
      $('.modal-body').html(res);

      $('#event_start_1i').val(year);
      $('#event_start_2i').val(month);
      $('#event_start_3i').val(day);

      $('#event_end_1i').val(year);
      $('#event_end_2i').val(month);
      $('#event_end_3i').val(day);

      $('#modal').fadeIn();
    }).fail(function (result) {
      alert("failed");
    });
  });
});


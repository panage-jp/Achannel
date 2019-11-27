$(function () {
  // メッセージおよびスレッドの削除をするために入力したパスワードを削除のためのフォームにも入力
  $(".password_revealed").keyup(function () {
    let pass_id = $(this).data("id")
    let pass = $(this).val()
    $(`.password_hidden[id=${pass_id}]`).val("")
    $(`.password_hidden[id=${pass_id}]`).val(pass)

  })

  // スレッド作成時およびレスポンス作成時にパスワードとメッセージが空白の場合のアラート
  $("#submit_button").click(function (e) {
    let alert_message = ""
    if ($("#submit_title").val() === "") {
      e.preventDefault();
      alert_message += "タイトルを入力してください。\n"
    }
    if ($("#submit_password").val() === "") {
      e.preventDefault();
      alert_message += "パスワードを入力してください。\n"
    }
    if ($("#submit_name").val() === "") {
      e.preventDefault();
      alert_message += "名前を入力してください。\n"
    }
    if ($("#submit_content").val() === "") {
      e.preventDefault();
      alert_message += "本文を入力してください。\n"
    }
    if (alert_message != "") {
      alert(alert_message)
    }
  })

  // インクリメンタルサーチ
  function appendThread(index, thread) {
    const html = `  <div class="media">
    <div class="media-body">
      <a href="/rooms/${thread.id}">${thread.title}(${thread.res_num})</a>
      <div class="content_created_at">${thread.created_at}</div>
    </div>
  </div>`
    threads_list.append(html)
  }

  function appendMessage(message) {
    const html = `<div class="media nomessage">
                  <p >${message}</p>
                </div>`
    threads_list.append(html)
  }
  const threads_list = $('#thread-search-result');


  $('#thread-search-field').on('input', function (e) {
    e.preventDefault();
    // 入力内容を取得
    const input = $('#thread-search-field').val();
    $.ajax({
        type: 'GET',
        url: '/',
        dataType: 'json',
        data: {
          keyword: input
        },
      })
      .done(function (threads) {
        threads_list.empty();
        if (threads.length !== 0) {
          $.each(threads, function (index, thread) {
            appendThread(index, thread);
          })
        } else {
          appendMessage('スレッドが見つかりませんでした');
        }
      })
      .fail(function () {
        alert("ユーザー検索に失敗しました");
      })

  });

})
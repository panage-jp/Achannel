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

  // スレッド、レス、編集時のパスワードとメッセージが空白時のアラート
  // $("#submit_button_edit").click(function (e) {
  //   let alert_message = ""
  //   if ($("#submit_title_edit").val() === "") {
  //     e.preventDefault();
  //     alert_message += "タイトルを入力してください。\n"
  //   }
  //   if ($("#submit_password_edit").val() === "") {
  //     e.preventDefault();
  //     alert_message += "パスワードを入力してください。\n"
  //   }
  //   if ($("#submit_content_edit").val() === "") {
  //     e.preventDefault();
  //     alert_message += "本文を入力してください。\n"
  //   }
  //   if (alert_message != "") {
  //     alert(alert_message)
  //   }
  // })
})
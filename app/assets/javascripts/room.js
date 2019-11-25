// メッセージおよびスレッドの削除をするために入力したパスワードを削除のためのフォームにも入力
$(function () {
  $(".password_revealed").keyup(function () {
    let id = $(this).data("id")
    let pass = $(this).val()
    $(`.password_hidden[id=${id}]`).val("")
    $(`.password_hidden[id=${id}]`).val(pass)

  })
})
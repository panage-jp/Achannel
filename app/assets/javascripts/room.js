// メッセージおよびスレッドの削除をするために入力したパスワードを削除のためのフォームにも入力
$(function () {
  $(".password_revealed").keyup(function () {
    let pass_id = $(this).data("id")
    let pass = $(this).val()
    $(`.password_hidden[id=${pass_id}]`).val("")
    $(`.password_hidden[id=${pass_id}]`).val(pass)

  })
})
// app/views/items/_item.html.erb でサムネイル画像をクリックしたときに、メイン画像を切り替えるための JavaScript コード
$(function () {
    $(".thumbnail").on("click", function () {
        const src = $(this).attr("src");
        $("#main-image").attr("src", src);
    });
});
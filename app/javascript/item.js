// app/javascript/item.js
// app/views/items/_item.html.erb でサムネイル画像をクリックしたときに、メイン画像を切り替えるための JavaScript コード

document.addEventListener("turbo:load", () => {
    const thumbnails = document.querySelectorAll(".thumbnail");
    const mainImage = document.getElementById("main-image");

    thumbnails.forEach((thumbnail) => {
        thumbnail.addEventListener("click", () => {
            mainImage.src = thumbnail.src;
        });
    });
});
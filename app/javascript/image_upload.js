// app/javascript/image_upload.js


// import Sortable from "sortablejs"

document.addEventListener("turbo:load", () => {
    const input = document.getElementById("image_input")
    const trigger = document.getElementById("file_trigger")
    const preview = document.getElementById("preview")
    const imageFields = document.getElementById("image_fields")
    const existingContainer = document.getElementById("existing-images")
    const MAX_FILES = 10
    if (!input) return

    // ファイル選択
    trigger.addEventListener("click", () => input.click())

    // Sortable（新規画像だけ）
    Sortable.create(preview, { animation: 150 })

    // 既存画像削除
    document.addEventListener("click", e => {
        if (e.target.classList.contains("remove-existing-btn")) {
            const wrapper = e.target.closest(".existing-image")
            const imageId = wrapper.dataset.imageId

            const form = e.target.closest("form")
            const hidden = document.createElement("input")
            hidden.type = "hidden"
            hidden.name = "remove_image_ids[]"
            hidden.value = imageId
            form.appendChild(hidden)

            wrapper.remove()
        }
    })

    // 新規画像削除
    document.addEventListener("click", e => {
        if (e.target.classList.contains("remove-btn")) {
            const wrapper = e.target.closest(".preview-item")
            const hidden = wrapper.querySelector("input[type=file]")
            wrapper.remove()
            if (hidden) hidden.remove()
        }
    })

    // 新規画像追加
    input.addEventListener("change", e => {
        const files = Array.from(e.target.files)
        files.forEach(file => {
            const totalImages = files.length +
                preview.children.length +
                (existingContainer ? existingContainer.children.length : 0)
            if (totalImages > MAX_FILES) return alert(`画像は最大${MAX_FILES}枚です`)

            const reader = new FileReader()
            reader.onload = ev => {
                const wrapper = document.createElement("div")
                wrapper.classList.add("preview-item")

                const img = document.createElement("img")
                img.src = ev.target.result
                img.style.width = "80px"
                img.style.height = "80px"
                img.style.objectFit = "cover"
                img.style.border = "1px solid #ccc"
                img.style.borderRadius = "4px"

                const name = document.createElement("span")
                name.textContent = file.name

                const removeBtn = document.createElement("button")
                removeBtn.type = "button"
                removeBtn.innerText = "×"
                removeBtn.classList.add("remove-btn")

                // 新規画像用 hidden input を作成
                const dt = new DataTransfer()
                dt.items.add(file)
                const hidden = document.createElement("input")
                hidden.type = "file"
                hidden.name = "item[images][]"
                hidden.files = dt.files

                wrapper.appendChild(img)
                wrapper.appendChild(name)
                wrapper.appendChild(removeBtn)
                wrapper.appendChild(hidden)

                preview.appendChild(wrapper)
                imageFields.appendChild(hidden)
            }
            reader.readAsDataURL(file)
        })
        input.value = ""
    })
})

// テーブル行全体をクリック可能にする app/views/items/index.html.erb で tr に data-href 属性を追加し、クリックイベントで遷移させる
document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".clickable-row").forEach(row => {
        row.addEventListener("click", () => {
            window.location = row.dataset.href;
        });
    });
});


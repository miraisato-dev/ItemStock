# config/importmap.rb
# config/importmap.rb
pin "application", preload: true

pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

# 自動読み込みも残しつつ
pin_all_from "app/javascript/controllers", under: "controllers"

# ★個別に明示的にピン留めを追加（これで確実に見つかるようになります）
pin "controllers/item", to: "controllers/item.js"
pin "controllers/image_upload", to: "controllers/image_upload.js"

pin "@rails/activestorage", to: "activestorage.esm.js"
pin "chartkick", to: "https://ga.jspm.io/npm:chartkick@5.0.1/dist/chartkick.js"
pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.4.0/dist/chart.js"
pin "@kurkle/color", to: "https://ga.jspm.io/npm:@kurkle/color@0.3.2/dist/color.esm.js"
pin "sortablejs", to: "https://ga.jspm.io/npm:sortablejs@1.15.2/modular/sortable.esm.js"
// app/javascript/application.js
import "@hotwired/turbo-rails"
import "controllers"

import "chartkick"
import "chart.js"

import "controllers/item"
import "controllers/image_upload"

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()
// app/javascript/application.js
import "@hotwired/turbo-rails"
import "controllers"

import "chartkick"
import "chart.js"

import "item"
import "image_upload"

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()
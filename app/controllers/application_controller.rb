# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # before_action :authenticate_user! 未ログイン時にログイン画面に遷移することを防ぐ
  allow_browser versions: :modern
end

# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    # ログインしてたらダッシュボードへ
    redirect_to dashboard_path if current_user
  end
end

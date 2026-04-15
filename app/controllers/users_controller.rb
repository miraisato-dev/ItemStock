# app/controllers/users_controller.rb
class UsersController < ApplicationController
    before_action :set_user, only: [ :edit, :update, :edit_account, :update_account, :edit_profile, :update_profile, :profile ]   # edit/update用に@userをセット
    # before_action :require_login, only: [ :edit, :update, :edit_account, :update_account, :edit_profile, :update_profile, :profile ] # ログイン必須
    before_action :authenticate_user!

    # 新規登録画面
    def new
        @user = User.new
    end

    # 新規登録処理
    def create
        @user = User.new(user_params)
        if @user.save
        redirect_to login_path, notice: "登録が完了しました。ログインしてください。"
        else
        render :new, status: :unprocessable_entity
        end
    end

    # 新規登録画面遷移
    def edit
    end

    # 更新処理
    def update
        if @user.update(user_params)
        redirect_to edit_account_path, notice: "アカウント情報を更新しました"
        else
        render :edit, status: :unprocessable_entity
        end
    end

    # プロフィール
    def profile
        @user = current_user
    end

    # 新規追加：プロフィール編集
    def edit_profile
        @user = current_user
    end

    #
    def update_profile
        if @user.update(profile_params)
        redirect_to profile_path, notice: "プロフィールを更新しました"
        else
        render :edit_profile, status: :unprocessable_entity
        end
    end

    def account
        @user = current_user
    end

    # 新規追加：アカウント情報編集

    def update_account
    @user = current_user

    if params[:user][:password].present?
        # パスワード変更あり
        if @user.update_with_password(user_params)
        redirect_to account_path, notice: "更新しました"
        else
        render :edit_account
        end
    else
        # パスワード変更なし
        if @user.update_without_password(user_params)
        redirect_to account_path, notice: "更新しました"
        else
        render :edit_account
        end
    end
    end

    def edit_account
        @user = current_user
    end

    private

    def set_user
        @user = current_user
    end

    # Strong Parameters
    def user_params
        params.require(:user).permit(
            :email,
            :password,
            :password_confirmation,
          # :current_password
        )
    end

    def profile_params
        params.require(:user).permit(
        :name,
        :bio,
        :avatar
        )
    end

    def account_params
        params.require(:user).permit(
            :email,
            :password,
            :password_confirmation
        )
    end
end

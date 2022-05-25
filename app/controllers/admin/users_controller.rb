# frozen_string_literal: true

module Admin
  class UsersController < BaseController
    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(permitted_params)

      if @user.save
        flash[:notice] = I18n.t("shared.flash_messages.success")

        redirect_to admin_user_path(@user)
      else
        flash[:alert] = I18n.t("shared.flash_messages.error")

        render :new
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])

      if @user.update(permitted_params)
        flash[:notice] = I18n.t("shared.flash_messages.success")

        redirect_to admin_user_path(@user)
      else
        flash[:alert] = I18n.t("shared.flash_messages.error")

        render :edit
      end
    end

    def destroy
      user = User.find(params[:id])

      if user.destroy
        flash[:notice] = I18n.t("shared.flash_messages.success")
      else
        flash[:alert] = I18n.t("shared.flash_messages.error")
      end

      redirect_to admin_users_path
    end

    private

    def permitted_params
      params
        .require(:user)
        .permit(
          :email,
          :name,
          :password,
          :password_confirmation
        ).compact_blank
    end
  end
end

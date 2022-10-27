# frozen_string_literal: true

module Admin
  class UsersController < BaseController
    def index
      @users = policy_scope(authorize(User))
    end

    def show
      @user = authorize(User.find(params[:id]))
    end

    def new
      @user = authorize(User.new)
    end

    def edit
      @user = authorize(User.find(params[:id]))
    end

    def create
      @user = authorize(User.new(permitted_attributes(User)))

      if @user.save
        flash[:notice] = I18n.t("shared.flash_messages.success")

        redirect_to admin_user_path(@user)
      else
        flash.now[:alert] = I18n.t("shared.flash_messages.error")

        render :new
      end
    end

    def update
      @user = authorize(User.find(params[:id]))

      if @user.update(update_params)
        flash[:notice] = I18n.t("shared.flash_messages.success")

        redirect_to admin_user_path(@user)
      else
        flash.now[:alert] = I18n.t("shared.flash_messages.error")

        render :edit
      end
    end

    def destroy
      user = authorize(User.find(params[:id]))

      if user.destroy
        flash[:notice] = I18n.t("shared.flash_messages.success")
      else
        flash[:alert] = I18n.t("shared.flash_messages.error")
      end

      redirect_to admin_users_path
    end

    private

    def update_params
      permitted_attributes(@user).tap do |params|
        if params["password"].blank? && params["password_confirmation"].blank?
          params.delete("password")
          params.delete("password_confirmation")
        end
      end
    end
  end
end

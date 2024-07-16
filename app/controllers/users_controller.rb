# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :birthday)
  end
end

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # 新規登録時(sign_up時)にphone_numberとbirthdayというキーのパラメーターを追加で許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birthday, :phone_number])
  end
end

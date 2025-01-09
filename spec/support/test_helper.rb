# frozen_string_literal: true

module TestHelper
  def is_logged_in?
    !session[:user_id].nil?
  end
end

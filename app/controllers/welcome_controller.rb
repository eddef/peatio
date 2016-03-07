class WelcomeController < ApplicationController
  layout 'landing'

  def index
    if current_user
      redirect_to settings_url
    else
      redirect_to signin_url
    end
  end
end

class WelcomeController < ApplicationController
  layout 'landing'

  def index
    if current_user
      redirect_to settings_url
    end
  end
end

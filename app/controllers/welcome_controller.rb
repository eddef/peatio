class WelcomeController < SessionsController
  layout 'landing'
  helper_method :require_captcha?

  def index
    if current_user
      redirect_to settings_url
    end

    @identity = Identity.new
  end
end

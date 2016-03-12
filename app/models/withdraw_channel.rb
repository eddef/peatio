class WithdrawChannel < ActiveYaml::Base
  include Channelable
  include HashCurrencible
  include International

  class << self
    private
    def load_file
      Currency.all.map { |cu| cu.channels['withdraw'] }
    end
  end

  def blacklist
    self[:blacklist]
  end

  def as_json(options = {})
    super(options)['attributes'].merge({resource_name: key.pluralize})
  end

end

class DepositChannel < ActiveYaml::Base
  include Channelable
  include HashCurrencible
  include International

  class << self
    private
    def load_file
      Currency.all.map { |cu| cu.channels['deposit'] }
    end
  end

  def accounts
    bank_accounts.map {|i| OpenStruct.new(i) }
  end

  def as_json(options = {})
    super(options)['attributes'].merge({resource_name: key.pluralize})
  end

  def <=>(other)
    self.sort_order <=> other.sort_order
  end
end

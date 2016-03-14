module ActiveModel
  module Translation
    alias :han :human_attribute_name
  end
end

ActiveRecord::Base.extend ActiveHash::Associations::ActiveRecordExtensions

class Coindeposit < ::Deposit
  include ::AasmAbsolutely
  include ::Deposits::Coinable
end

class Bankdeposit < ::Deposit
  include ::AasmAbsolutely
  include ::Deposits::Bankable
  include ::FundSourceable

  def charge!(txid)
    with_lock do
      submit!
      accept!
      touch(:done_at)
      update_attribute(:txid, txid)
    end
  end
end

class Coinwithdraw < ::Withdraw
  include ::AasmAbsolutely
  include ::Withdraws::Coinable
  include ::FundSourceable
end

class Bankwithdraw < ::Withdraw
  include ::AasmAbsolutely
  include ::Withdraws::Bankable
  include ::FundSourceable
end





Currency.all.each do |currency|
  if currency.coin?

    Object.const_set("Deposits::#{currency.key.capitalize}", Class.new(Coindeposit))

    Object.const_set("Withdraws::#{currency.key.capitalize}", Class.new(Coinwithdraw))

  else

    Object.const_set("Deposits::#{currency.key.capitalize}", Class.new(Bankdeposit))

    Object.const_set("Withdraws::#{currency.key.capitalize}", Class.new(Bankwithdraw))

  end
end


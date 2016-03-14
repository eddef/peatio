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

    eval %Q{class Deposits::#{currency.key.capitalize} < Coindeposit; end; }
    eval %Q{class Withdraws::#{currency.key.capitalize} < Coinwithdraw; end; }


  else

    eval %Q{class Deposits::#{currency.key.capitalize} < Bankdeposit; end; }
    eval %Q{class Withdraws::#{currency.key.capitalize} < Bankwithdraw; end; }

  end
end


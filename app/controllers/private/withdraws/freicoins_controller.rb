module Private::Withdraws
  class FreicoinsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end

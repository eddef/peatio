module Deposits
  class Freicoin < ::Deposit
    include ::AasmAbsolutely
    include ::Deposits::Coinable
  end
end

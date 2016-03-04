module Admin
  module Withdraws
    class FreicoinsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Freicoin'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_freicoins = @freicoins.with_aasm_state(:accepted).order("id DESC")
        @all_freicoins = @freicoins.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @freicoin.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @freicoin.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end

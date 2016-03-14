module Admin
  module Withdraws
    class CoinsController < ::Admin::BaseController
      #load_and_authorize_resource :class => "::Withdraws::#{ params[:type].capitalize }"

      before_action :find_withdraw, only: [:show, :update, :destroy]
      before_action :find_withdraws, only: [:index]

      def channel
        @channel ||= WithdrawChannel.find_by_key(params[:type])
      end

      def kls
        channel.kls
      end

      def find_withdraw
        @coin = channel.kls.find(params[:id])

        if @coin.may_process? and (@coin.amount > @coin.account.locked)
          flash[:alert] = 'TECH ERROR !!!!'
          redirect_to action: :index
        end
      end

      def find_withdraws
        currency_id = Currency.where(key: params[:type]).first.id
        @coins = Withdraw.where(currency: currency_id)
      end

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @currency = params[:type]
        @one_coin = @coins.with_aasm_state(:accepted).order("id DESC")
        @all_coins = @coins.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @coin.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @coin.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end

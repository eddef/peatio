module Admin
  module Withdraws
    class CoinsController < ::Admin::BaseController
      #load_and_authorize_resource :class => "::Withdraws::#{ params[:type].capitalize }"

      before_action :find_withdraw, only: [:show, :update, :destroy]

      def channel
        @channel ||= WithdrawChannel.find_by_key(self.controller_name.singularize)
      end

      def kls
        channel.kls
      end

      def find_withdraw
        w = channel.kls.find(params[:id])
        self.instance_variable_set("@#{self.controller_name.singularize}", w)
        raise "@#{ params[:type].capitalize.singularize }".inspect
        if w.may_process? and (w.amount > w.account.locked)
          flash[:alert] = 'TECH ERROR !!!!'
          redirect_to action: :index
        end
      end

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_satoshis = @satoshis.with_aasm_state(:accepted).order("id DESC")
        @all_satoshis = @satoshis.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @satoshi.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @satoshi.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end

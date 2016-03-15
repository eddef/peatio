module Admin
  module Withdraws
    class FiatsController < ::Admin::BaseController
      load_and_authorize_resource :class => '::Withdraws::Bank'

      before_action :find_withdraw, only: [:show, :update, :destroy]

      def channel
        @channel ||= WithdrawChannel.find_by_key(self.controller_name.singularize)
      end

      def find_withdraw
        w = channel.kls.find(params[:id])
        self.instance_variable_set("@#{self.controller_name.singularize}", w)
        if w.may_process? and (w.amount > w.account.locked)
          flash[:alert] = 'TECH ERROR !!!!'
          redirect_to action: :index
        end
      end

      def index
        @one_banks = @banks.with_aasm_state(:accepted, :processing).order("id DESC")
        @all_banks = @banks.without_aasm_state(:accepted, :processing).where('created_at > ?', 24.hours.ago).order("id DESC")
      end

      def show
      end

      def update
        if @bank.may_process?
          @bank.process!
        elsif @bank.may_succeed?
          @bank.succeed!
        end

        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @bank.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end

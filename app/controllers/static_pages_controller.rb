class StaticPagesController < ApplicationController
  def home
    #@payments = Payment.all
    @q        = current_user.payments.search(params[:q])
    @payments = @q.result(distinct: true).order(settlement_date: :desc)
    @spending = @payments.where(balance: "支出").sum(:price)
    @income = @payments.where(balance: "収入").sum(:price)
  end
end 
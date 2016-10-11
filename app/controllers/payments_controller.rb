class PaymentsController < ApplicationController
  def index
    @payments = Payment.all
    @payment = Payment.new
  end
  
  def create
    @payment = current_user.payments.build(payment_params)
    if @payment.save
      redirect_to payments_path, notice: "success"
    else
      @payments = Payment.all
      render 'index'
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:balance, :price, :description, :settlement_date)
  end
  
end

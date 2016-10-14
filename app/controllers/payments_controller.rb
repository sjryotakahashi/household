class PaymentsController < ApplicationController
  before_action :set_params, only: [:edit, :update]
  
  def index
    @payments = Payment.all
    @payment = Payment.new
    @payments = Payment.paginate(page: params[:page])
  end
  
  def create
    @payment = current_user.payments.build(payment_params)
    if @payment.save
      flash[:success] = "Success"
      redirect_to payments_path
    else
      @payments = Payment.all
      render 'index'
    end
  end
  
  def edit
  end
  
  def update
    if @payment.update(payment_params)
      flash[:success] = "Updated Profile!"
      redirect_to payments_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @payment = current_user.payments.find_by(id: params[:id])
    return redirect_to root_url if @payment.nil?
    @payment.destroy
    flash[:success] = "Deleted"
    redirect_to payments_path
  end


  private

  def payment_params
    params.require(:payment).permit(:settlement_date, :balance, :description, :price)
  end
  
  def set_params
    @payment = Payment.find(params[:id])
  end
end
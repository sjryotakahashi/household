class PaymentsController < ApplicationController
  before_action :set_params, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :logged_in_user, except: [:edit, :update]
  
  def index
    @payment = current_user.payments.build
    @payments = current_user.payments.order(settlement_date: :desc).paginate(page: params[:page])
  end
  
  def create
    @payment = current_user.payments.build(payment_params)
    if @payment.save
      flash[:success] = "作成しました"
      redirect_to payments_path
    else
      @payments = current_user.payments.order(settlement_date: :desc).paginate(page: params[:page])
      render 'index'
    end
  end
  
  def edit
  end
  
  def update
    if @payment.update(payment_params)
      flash[:success] = "更新しました"
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @payment = current_user.payments.find_by(id: params[:id])
    return redirect_to root_url if @payment.nil?
    @payment.destroy
    flash[:success] = "削除しました"
    redirect_to root_path
  end


  private

  def payment_params
    params.require(:payment).permit(:settlement_date, :balance, :description, :price)
  end
  
  def set_params
    @payment = Payment.find(params[:id])
  end
  
  def correct_user
    redirect_to root_path if @payment.user != current_user
  end
end
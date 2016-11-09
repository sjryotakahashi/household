class PaymentsController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show,:edit, :update]
  before_action :logged_in_user, except: [:show,:edit, :update]

  def index
    if logged_in?
      @q        = current_user.payments.search(params[:q])
      @payments = @q.result(distinct: true).order(settlement_date: :desc).paginate(page: params[:page])
      @spending = @payments.where(balance: "支出").sum(:price)
      @income = @payments.where(balance: "収入").sum(:price)
    end
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = current_user.payments.build(payment_params)
    if @payment.save
      flash[:success] = "データを作成しました"
      redirect_to @payment
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @payment.update(payment_params)
      flash[:success] = "データを更新しました"
      redirect_to payments_path
    else
      render 'edit'
    end
  end

  def destroy
    @payment = current_user.payments.find_by(id: params[:id])
    return redirect_to root_url if @payment.nil?
    @payment.destroy
    flash[:success] = "データを削除しました"
    redirect_to payments_path
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

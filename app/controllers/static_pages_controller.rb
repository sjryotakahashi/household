class StaticPagesController < ApplicationController
  def home
    #@payments = Payment.all
    @q        = Payment.search(params[:q])
    @payments = @q.result(distinct: true)
  end
end
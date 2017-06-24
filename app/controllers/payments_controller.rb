class PaymentsController < ApplicationController
  def create
    @product = Product.find params[:product_id]
    require 'payjp'
    Payjp.api_key = 'sk_test_c62fade9d045b54cd76d7036'
    token = Payjp::Token.create(
      :card => {
        :number => params[:number].tr(' ', '').tr('-', ''),
        :cvc => params[:cvc],
        :exp_month => params[:exp_month],
        :exp_year => params[:exp_year]
      }
    )
    charge = Payjp::Charge.create(
      :amount => @product.price,
      :card => token,
      :currency => 'jpy',
    )
  end
end

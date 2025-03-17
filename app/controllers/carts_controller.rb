class CartsController < ApplicationController
  before_action :authenticate_user!

  def add_item
    @cart = current_user.cart || current_user.create_cart(status: 'active')

    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0

    item = @cart.cart_items.find_by(car_id: params[:car_id])

    if item
      item.update(quantity: item.quantity + quantity)
    else
      @cart.cart_items.create(car_id: params[:car_id], quantity: quantity)
    end

    redirect_to cart_path, notice: 'Carro adicionado ao carrinho!'
  end

  def remove_item
    @cart = current_user.cart
    item = @cart.cart_items.find_by(car_id: params[:car_id])

    if item
      item.destroy
      flash[:notice] = 'Carro removido do carrinho!'
    else
      flash[:alert] = 'Carro não encontrado no carrinho.'
    end

    redirect_to cart_path
  end

  def show
    @cart = current_user.cart || current_user.create_cart(status: 'active')
  end
end

class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(:reservation_items) || []
  end

  def new
    @cart = current_user.cart || current_user.create_cart(status: 'active')
    if @cart.cart_items.empty?
      redirect_to cart_path, alert: "Seu carrinho está vazio!"
    else
      @reservation = Reservation.new
    end
  end

  def create
    @cart = current_user.cart
    @reservation = current_user.reservations.build(reservation_params)

    # Cálculo do preço total baseado nos itens do carrinho
    total_price = 0
    @cart.cart_items.each do |item|
      total_price += item.car.daily_rental_price * (reservation_params[:end_date].to_date - reservation_params[:start_date].to_date).to_i * item.quantity
    end

    @reservation.total_price = total_price # Definindo o preço total

    if @reservation.save
      # Criando os itens da reserva
      @cart.cart_items.each do |cart_item|
        @reservation.reservation_items.create(
          car: cart_item.car,
          quantity: cart_item.quantity
        )
      end

      # Finalizando o carrinho
      @cart.update(status: 'completed')
      @cart.cart_items.destroy_all

      redirect_to reservations_path, notice: "Reserva realizada com sucesso!"
    else
      render :new
    end
  end

  def cancel
    @reservation = current_user.reservations.find(params[:id])

    if @reservation.start_date > Date.today
      @reservation.destroy
      redirect_to reservations_path, notice: "Reserva cancelada com sucesso."
    else
      redirect_to reservations_path, alert: "Não é possível cancelar uma reserva que já começou."
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end

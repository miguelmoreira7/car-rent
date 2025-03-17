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
      
        if @reservation.save
          @cart.cart_items.each do |cart_item|
            @reservation.reservation_items.create(
              car: cart_item.car,
              quantity: cart_item.quantity
            )
          end
      
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
  
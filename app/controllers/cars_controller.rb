class CarsController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:index]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @cars = Car.all
    @cars = @cars.where(manufacturer_id: params[:manufacturer]) if params[:manufacturer].present?
    @cars = @cars.where(model: params[:model]) if params[:model].present?
    @cars = @cars.where(year: params[:year]) if params[:year].present?
    @cars = @cars.where(fuel_type: params[:fuel_type]) if params[:fuel_type].present?
  end
end
class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: 'Usuário criado com sucesso!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :cpf, :email, :password, :password_confirmation)
  end
end
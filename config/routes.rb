Rails.application.routes.draw do
  # Autenticação com Devise
  devise_for :users

  # Página inicial apontando para a listagem de carros
  root 'cars#index'

  # Rotas de carros
  resources :cars, only: [:index, :show]

  # Carrinho de aluguel
  resource :cart, only: [:show] do
    post 'add_item'
    delete 'remove_item'
    post 'checkout', on: :collection
  end

  #rotas de reservas
  resources :reservations, only: [:index, :new, :create] do
    member do
      patch :cancel
    end
  end

end

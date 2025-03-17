class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Usuário convidado (não autenticado)

    if user.admin?
      can :manage, :all  # Admin pode gerenciar tudo
    else
      can :read, Car   # Usuário comum pode ver a lista de carros
      can :manage, ::Cart, user_id: user.id
    end
  end
end

Canard::Abilities.for(:player) do
  can [:read], Challenge
  cannot [:create][:update][:destroy], Challenge
end

Canard::Abilities.for(:creator) do
    can [:read][:create][:update][:destroy], Challenge
    cannot [:destroy],User

end

Canard::Abilities.for(:admin) do
    includes_abilities_of :creator
    can [:destroy],User
end

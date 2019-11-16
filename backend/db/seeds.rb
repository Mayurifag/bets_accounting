# frozen_string_literal: true

BetType.find_or_create_by!(name: "Прематч")
BetType.find_or_create_by!(name: "Лайв")

ResultVariant.find_or_create_by!(id: 1, name: "Победа")
ResultVariant.find_or_create_by!(id: 2, name: "Проигрыш")
ResultVariant.find_or_create_by!(id: 3, name: "Возврат")

Discipline.find_or_create_by!(name: "Dota 2")
Discipline.find_or_create_by!(name: "Теннис")
Discipline.find_or_create_by!(name: "CS:GO")
Discipline.find_or_create_by!(name: "Футбол")

Bookmaker.find_or_create_by!(name: "Другая")
Bookmaker.find_or_create_by!(name: "GG.Bet")
Bookmaker.find_or_create_by!(name: "Париматч")
Bookmaker.find_or_create_by!(name: "EGB")
Bookmaker.find_or_create_by!(name: "Loot.Bet")
Bookmaker.find_or_create_by!(name: "Leon")

15.times { Participant.find_or_create_by(name: Faker::Esport.team) }

5.times { Event.find_or_create_by(name: Faker::Esport.event) }

User.destroy_all
User.create!(email: "test@test.test", password: "qwerty", password_confirmation: "qwerty")

Bet.delete_all
Generator.generate_bets(100)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

BetType.find_or_create_by!(name: 'Прематч')
BetType.find_or_create_by!(name: 'Лайв')

5.times { Discipline.find_or_create_by(name: Faker::Esport.game) }

Bookmaker.find_or_create_by!(name: 'GG.Bet')
Bookmaker.find_or_create_by!(name: 'Париматч')
Bookmaker.find_or_create_by!(name: 'EGB')
Bookmaker.find_or_create_by!(name: 'Loot.Bet')

ResultVariant.find_or_create_by!(name: 'Победа')
ResultVariant.find_or_create_by!(name: 'Возврат')
ResultVariant.find_or_create_by!(name: 'Проигрыш')

15.times { Participant.find_or_create_by(name: Faker::Esport.team) }

5.times { Event.find_or_create_by(name: Faker::Esport.event) }

25.times do
  Bet.create!(choice1: Participant.find(Participant.ids.sample).name,
              choice2: Participant.find(Participant.ids.sample).name,
              wager: rand(1000..100_000),
              coefficient: rand(1.2...3.0).ceil(2),
              outcome: 'П' + rand(1..2).to_s,
              comment: 'random comment ' + rand(1000..9999).to_s,
              discipline_id: Discipline.find(Discipline.ids.sample).id,
              bookmaker_id: Bookmaker.find(Bookmaker.ids.sample).id,
              result_variant_id: ResultVariant.find(ResultVariant.ids.sample).id,
              bet_type_id: BetType.find(BetType.ids.sample).id)
end

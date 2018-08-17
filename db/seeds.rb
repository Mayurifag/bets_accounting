# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

BetType.find_or_create_by!(name: 'Прематч')
BetType.find_or_create_by!(name: 'Лайв')

Discipline.find_or_create_by!(name: 'Dota 2')
Discipline.find_or_create_by!(name: 'Теннис')

Bookmaker.find_or_create_by!(name: 'GG.Bet')
Bookmaker.find_or_create_by!(name: 'Париматч')
Bookmaker.find_or_create_by!(name: 'EGB')
Bookmaker.find_or_create_by!(name: 'Loot.Bet')

ResultVariant.find_or_create_by!(name: 'Победа')
ResultVariant.find_or_create_by!(name: 'Возврат')
ResultVariant.find_or_create_by!(name: 'Проигрыш')

Participant.find_or_create_by!(name: 'NaVi')
Participant.find_or_create_by!(name: 'Secret')
Participant.find_or_create_by!(name: 'Касаткина')
Participant.find_or_create_by!(name: 'Остапенко')
Participant.find_or_create_by!(name: 'Team Liquid')
Participant.find_or_create_by!(name: 'PSG.LGD')
Participant.find_or_create_by!(name: 'Winstrike')
Participant.find_or_create_by!(name: 'Саккари')

# if discipline.participants.empty?
#   discipline.participants << side1
#   discipline.participants << side2
# end

20.times do
  random_wager = rand(1000..100000)
  outcome = if random_wager.even?
              'П2'
            else
              'П1'
            end
  random_comment = 'random comment' + rand(1000..9999).to_s

  bet = Bet.create!(choice1: Participant.find( Participant.ids.shuffle.first ).name,
                    choice2: Participant.find( Participant.ids.shuffle.first ).name,
                    wager: random_wager,
                    coefficient: rand(1.2...3.0).ceil(2),
                    outcome: outcome,
                    comment: random_comment,
                    discipline_id: Discipline.find( Discipline.ids.shuffle.first ).id,
                    bookmaker_id: Bookmaker.find( Bookmaker.ids.shuffle.first ).id,
                    result_variant_id: ResultVariant.find( ResultVariant.ids.shuffle.first ).id,
                    bet_type_id: BetType.find( BetType.ids.shuffle.first ).id)

  bet.save! # trigger profit count
end

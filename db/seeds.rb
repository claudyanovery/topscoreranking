# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Seeding..'

Score.create([
               { player: 'Peter', score: 4 },
               { player: 'Mark', score: 3 },
               { player: 'Matt', score: 3 },
               { player: 'peter', score: 1 },
               { player: 'mArk', score: 2 },
               { player: 'mat', score: 2 }
             ])

puts 'Seeding done!'

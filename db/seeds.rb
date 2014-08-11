# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create [
  { username: "oscar123", password: "123456" },
  { username: "piggie_for_life", password: "123456" },
  { username: "kermit", password: "123456" },
  { username: "elmozzz", password: "123456" }
]

Sub.create [
  { name: "The Street", 
    description: "The best sub on this site", 
    moderator_id: 1 },
    
  { name: "Muppets Galore", 
    description: "For all things muppets", 
    moderator_id: 3 }
]


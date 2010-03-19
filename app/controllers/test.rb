require 'rubygems'
require 'faker'


items = []
10.times do 
  items.push [Faker::Name.first_name]
end

puts items

Item.find(1)

items.each do |item|
  items.create({
    :name => item[0]
  })
end


#!/usr/bin/env ruby

# Amenitiz Tech Challenge
# $ ruby shop.rb

# Recursively load all libraries inside the ./lib directory
Dir[Dir.pwd + "/lib/**/*.rb"].each { |f| require f }

puts "Welcome to Amenitiz Supermarket"

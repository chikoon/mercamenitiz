#!/usr/bin/env ruby

# Amenitiz Tech Challenge
# $ ruby shop.rb

# Recursively load all libraries inside the ./lib directory
Dir[Dir.pwd + "/lib/**/*.rb"].each { |f| require f }

loop {
    puts "Welcome to Amenitiz Supermarket"
    input = gets.strip
    puts ("%s coming soon!" % input) if input.length > 0
}

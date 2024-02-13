#!/usr/bin/env ruby

# -- Amenitiz Tech Challenge -------------------------- February 2024 --
#    Author: Mike Blake             mike@chikoon.com, +34 652 927 813

# -- How to execute ----------------------------------------------------
#    $ ruby main.rb

# -- Load classes ------------------------------------------------------
#    Recursively load all libraries inside the ./lib directory
Dir[Dir.pwd + "/lib/**/*.rb"].each { |f| require f }

# -- Read in product data ----------------------------------------------
#    To-do: read this in from a csv or yaml file
#    4-now: copy product data directly from REQUIREMENTS
#           and paste in here.
raw_product_data = %{
    GR1, Green Tea,    3.11€
    SR1, Strawberries, 5.00 €
    CF1, Coffee,       11.23 €
}

parse_data = Proc.new {|d|
    # remove leading space on each line
    # remove leading and trailing spaces
    # remove redundant spaces, replace > 1 space with a single space
    # make an array of lines
    # each line split by comma (code, name, price)
    d.gsub(/\n\s*/, "\n").strip.split("\n").
    map{|row| row.gsub(/[\s]+/, ' ').split(",").map{|e| e.strip } }
}

product_data = parse_data.call(raw_product_data)


# -- Promos ------------------------------------------------------------
#    To-do: Dynamically load these promos or make their inclusion
#           easier, perhaps in an external config file, yaml, etc.
#    4-now: List the promos to include in the following array.
#           Use the name of the Promo subclass. See ./lib/promos
product_promos = [
    #TwoForOneTea
    #BulkStrawberries
    #BulkCoffee
]

# -- Get this party started --------------------------------------------
store = Store.new('MercAmenitiz')

product_data.each{   |row|
    product = Product.new(*row)
    store.add_product product
    puts "Add product to #{store.name}: %s" % product.to_s
}

product_promos.each{ |promo| store.add_promo(promo) }

cli = CLI.new(store).enter

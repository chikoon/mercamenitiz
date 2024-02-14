#!/usr/bin/env ruby

# -- Amenitiz Tech Challenge -------------------------- February 2024 --
#    Author: Mike Blake             mike@chikoon.com, +34 652 927 813

# -- How to execute ----------------------------------------------------
#    $ ruby mercamenitiz.rb

# -- Load classes ------------------------------------------------------
#    Recursively load all libraries inside the ./lib directory
Dir[Dir.pwd + "/lib/**/*.rb"].each { |f| require f }

# -- Read in product data ----------------------------------------------
#    To-do: read this in from a csv or yaml file
#    4-now: copy product data directly from REQUIREMENTS
#           and paste in here.

product_data = AppUtil.parse_csv(%{
    GR1, Green Tea,    3.11€
    SR1, Strawberries, 5.00 €
    CF1, Coffee,       11.23 €
})

# -- Promos ------------------------------------------------------------
#    To-do: Dynamically load these promos or make their inclusion
#           easier, perhaps in an external config file, yaml, etc.
#    4-now: List the promos to include in the following array.
#           Use the name of the Promo subclass. See ./lib/promos
product_promos = [ TwoForOneTea, BulkStrawberries, BulkCoffee ]

# -- Get this party started --------------------------------------------
store = Store.new('MercAmenitiz')

product_data.each{   |row|   store.add_product Product.new(*row) }
product_promos.each{ |promo| store.add_promo(promo.new) }

cli = CLI.new(store).enter

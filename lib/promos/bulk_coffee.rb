class BulkCoffee < Promo

    def blurb; "Buy 3 or more coffee boxes, and pay 33% less per unit"; end

    def check(items)
        coffees = items.select { |i| i.code === "CF1" }
        return unless coffees.size > 2
        coffees.each{ |coffee|
            coffee.price = (coffee.price/3)*2
        }
        true
    end

end

class BulkStrawberries < Promo

    def blurb; "Buy 3 or more strawberries, and pay only 4.50€ per unit"; end

    def check(items)
        strawberries = items.select { |i| i.code === "SR1" }
        return unless strawberries.size > 2
        strawberries.each{ |strawberry|
            strawberry.price = 4.50
        }
        true
    end

end

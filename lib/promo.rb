class Promo

    def blurb
        raise "Expected a promo :blurb to describe the offer"
    end

    def check(products)
        raise %{
            Expected :check method implementation
            Examine the products list.
            When applicable, modify prices and return TRUE.
            Otherwise, return FALSE
        }.gsub(/\n\s*/, ' ')

        # Example: Get 25% off on all EGGs
        eggbox = products.select{|product| product.code === 'EGG' }
        return false unless eggbox.size > 0
        eggbox.each{|eggbox| eggbox.price = eggbox.price * 0.75 }
        true
    end

end
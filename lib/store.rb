class Store
    attr_accessor :name, :products, :promos, :cart

    def initialize(store_name)
        @name = store_name
        @products = []
        @promos = []
        @cart = Cart.new
    end

    def add_promo(promo)
        unless @promos.include?(promo)
            @promos << promo
        end
    end

    def add_product(product)
        valid =  (product.is_a?(Product) && product.valid?)
        raise "Expected a valid product" unless valid
        unless product_exists?(product.code)
            @products << product
        end
    end

    def check_promos
        blurbs = []
        @promos.each { |promo|
            next unless promo.check(@cart.items) # no discount applied
            blurbs << promo.blurb
        }
        discounted_total = @cart.items.collect{|i| i.price}.inject(0, :+)
        [blurbs, discounted_total]
    end

    def checkout
        output = []
        @cart.items.map{|i| output << i.to_s } # cart contents
        total = @cart.items.collect{|i| i.price}.inject(0, :+)
        promos, discounted_total = check_promos
        if promos.size > 0
            output << 'SUBTOTAL: %s€' % sprintf("%.2f", total)
            output << '%i promo%s applied:' % [
                promos.size,
                (promos.size === 1) ? '' : 's'
            ]
            promos.each{|blurb| output << '- ' + blurb }
            output << 'DISCOUNT: %s€' % sprintf("%.2f", (total - discounted_total))
            output << 'TOTAL:    %s€' % sprintf("%.2f", discounted_total)
        else
            output << 'TOTAL: %s€' % total
        end
        output
    end

    def find_product(code)
        @products.each{|product| return product if product.code == code }
        raise "Product not found: #{code}"
    end

    def product_codes; @products.collect(&:code); end

    def product_exists?(code); product_codes.include? code; end

    def promo_list; @promos.collect{|promo| promo.blurb }; end

    def product_list
        output = []
        if(@products.size == 0)
            output << "#{@store.name} is fresh out of products. Sorry!"
            return
        end
        @products.each{ |product| output << product.to_s }
        output
    end

end

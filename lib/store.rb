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

    def calculate_total
        1.11
    end

    def checkout
        output = ['CHECKOUT']
        # byebug
        output = output + @cart.items.map{|i| i.to_s}
        #output << @discounts.join("\n") if info.size > 0
        output << 'TOTAL: %s' % calculate_total
        output
    end

    def find_product(code)
        @products.each{|product| return product if product.code == code }
        raise "Product not found: #{code}"
    end

    def product_exists?(code); product_codes.include? code; end

    def product_codes; @products.collect(&:code); end

    def product_list
        output = []
        if(@products.size == 0)
            output << "#{@store.name} is fresh out of products. Sorry!"
            return
        end
        @products.each{ |product| output << product.to_s }
        output
    end

    def subtotal; calculate_total; end

end

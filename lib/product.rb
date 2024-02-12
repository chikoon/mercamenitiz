class Product
    attr_accessor :code, :name, :price, :errors

    def initialize(code, myname, price, num_format: ':i€')
        @code   = code.to_s.upcase
        @name   = myname.to_s
        @price  = price.to_f
        @format = num_format.to_s
    end

    def price_str; '%s€' % sprintf("%.2f", @price); end

    def to_a; [@code, @name, price_str]; end
    def to_s; to_a.join(', '); end

    def valid?
        check = { # validations
            code: !!(@code.to_s.match(/^[A-Z]{3}$/)),
            name: !!(@name.to_s.match(/^.+$/)),
            price: (@price.is_a?(Float) && @price > 0)
        }
        msgs = {   # error messages
            code:  'Expected a three-letter, uppercase code',
            name:  'Expected a name',
            price: 'Expected price to be greater than 0'
        }
        @errors = {} # reset error hash
        check.each{ |nick, isvalid| @errors[nick] = msgs[nick] unless isvalid }
        !!(@errors.size == 0)
    end

    def validate!
        unless valid?
            msg = ["PRODUCT_ERROR"]
            @errors.each{ |k, v| msg.push('%s:%s' % [k,v]) }
            raise msg.join("\n")
        end
    end
end
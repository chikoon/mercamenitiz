class Cart
    attr_accessor :items

    def initialize; @items = []; end

    def add(product)
        valid = product.is_a?(Product) && product.valid?
        raise "Expected a valid product" unless valid
        @items << product
    end

    def contains?(code); count(code) > 0; end

    def count(code=nil)
        return @items.size unless code
        @items.select{|i| i.code === code }.size
    end

    def empty?; size === 0; end
    def empty!; @items = []; end

    def remove(code, all=false)
        sz_before = @items.size
        @items.each_with_index {|item, idx|
            if item.code === code
                @items[idx] = nil
                break unless all
            end
        }
        @items.compact!
        sz_changed = sz_before - @items.size
        sz_changed
    end

    def remove_all(code); remove(code, true); end
    def remove_one(code); remove(code); end
    def size; count; end
end


class CLI
    attr_accessor :store

    def initialize(store)
        @store = store
        @hint  = "Type option (H/L/A/R/C/S/X or HELP) and hit ENTER."
    end

    def enter
        #puts "Welcome to #{@store.name}!"
        puts separator "Welcome to #{@store.name}!"

        display_choices

        loop {
            puts separator
            puts @hint
            choice = gets.strip
            puts
            done = execute_choice choice
            if done; say_goodbye; break; end
        }
    end


    private

    def display_choices
        puts separator 'Option Menu'
        puts %{
            [H] Show this option menu
            [L] List products
            [A] Add item to cart
            [R] Remove item from cart
            [C] Show cart contents
            [X] Checkout
            [Q] Quit
        }.gsub(/\n\s*/, "\n").strip
    end

    def execute_choice(raw_choice)
        choice = raw_choice.to_s.strip.upcase
        return unless choice.size > 0
        case choice
            when /^(H|HELP)$/;     option_h_show_help
            when /^(L|LIST)$/;     option_l_list_products
            when /^(A|ADD)$/;      option_a_add_item_to_cart
            when /^(R|REMOVE)$/;   option_r_remove_item_from_cart
            when /^(C|CART)$/;     option_c_show_cart
            when /^(S|SUBTOTAL)$/; option_s_subtotal
            when /^(X|CHECKOUT)$/; option_x_checkout; return true;
            when /^(Q|QUIT)$/;     return true
            else; puts "ERROR: Invalid option \"#{choice}\". Please try again."
        end
        false
    end

    def option_a_add_item_to_cart
        a_hint = "Type product CODE and hit ENTER to add an item to your cart:"
        puts separator 'Choose from our list of products'
        puts @store.product_list
        puts separator
        puts a_hint
        begin
            product = @store.find_product(gets.upcase.strip)
            @store.cart.add product
            puts "Added: %s" % product.to_s
        rescue => e; puts "ERROR: %s" % e.to_s; end
    end

    def option_c_show_cart; show_cart; end

    def option_h_show_help; display_choices; end

    def option_l_list_products
        puts separator 'Our Products'
        puts @store.product_list
    end

    def option_r_remove_item_from_cart
        if @store.cart.empty?; puts "Your cart is empty"; return; end
        puts "Type the product CODE of the item you'd like to REMOVE to your cart:"
        code = gets.upcase.strip
        begin
            product = @store.find_product code
            if @store.cart.contains?(code)
                removed = @store.cart.remove_one code
                raise "Nothing removed from cart" unless removed === 1
                puts "Removed one #{product.code} (#{product.name}) from your cart"
            elsif 
                puts "You have no %s in your cart" % product.name
            end
        rescue => e
            puts "ERROR: %s" % e.to_s
        end
    end

    def option_s_subtotal
        puts @store.subtotal
    end

    def option_x_checkout
        puts @store.checkout
    end

    def say_goodbye
        puts "Thankyou for shopping at #{@store.name}. Come back soon! Goodbye"
    end

    def separator(title=nil)
        len = 72
        chr = '-'
        tit = (title) ? ('[%s] ' % title) : nil
        return chr * len unless tit
        tit + (chr * (len - tit.size))
    end

    def show_cart
        if @store.cart.empty?
            puts 'Your cart is empty'
            return
        end
        puts separator 'Your Cart'
        puts @store.cart.items.map{|item| item.to_s }
    end
end
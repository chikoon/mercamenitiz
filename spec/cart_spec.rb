RSpec.describe Cart, type: :class do

    before(:all){
        @product_1 = Product.new('AAA', 'AAA Batteries', '4.01')
        @product_2 = Product.new('ZZZ', 'ZZZ Sleeping Pills', '9.99')
    }

    context "instance should" do

        it "have an :items array property" do
            cart = Cart.new
            expect(cart.respond_to?(:items)).to be true
            expect(cart.send(:items).is_a?(Array)).to be true
        end

        it "respond to :size, returning the number of items" do
            cart = Cart.new
            expect(cart.size).to be 0
            cart.add @product_1
            expect(cart.size).to be 1
            cart.add @product_1
            expect(cart.size).to be 2
            cart.remove @product_1.code
            expect(cart.size).to be 1
            cart.remove @product_1.code
            expect(cart.size).to be 0
        end

        it "respond to :count, returning number of items for a given code" do
            cart = Cart.new
            cart.add @product_1
            cart.add @product_1
            cart.add @product_1
            cart.add @product_2
            expect(cart.count(@product_1.code)).to be 3
            expect(cart.count(@product_2.code)).to be 1
        end
    end

    context "adding items should" do

        it "fail when receiving anything but a valid product" do
            invalid_item = Product.new('ZZZZ', '', '-1')
            [nil, 'chicken', invalid_item].each{|bad_item|
                expect { @cart.add(bad_item) }.to raise_error(StandardError)
            }
        end

        it "be sucessfull" do
            cart = Cart.new
            valid_item = Product.new('AAA', 'AAA Batteries', '4.01')
            expect { cart.add valid_item }.not_to raise_error
            expect(cart.size).to be 1
        end

        it "allow for multiple items of the same product" do
            cart = Cart.new
            cart.add @product_1
            cart.add @product_1
            expect(cart.size).to be 2
        end
    end

    context "removing items should" do
        it "be sucessfull" do
            cart = Cart.new
            cart.add @product_1
            cart.add @product_1
            removed = cart.remove @product_1.code
            expect(removed).to be 1
            expect(cart.size).to be 1
        end

        it "should return 0 when no items are found for the given code" do
            cart = Cart.new
            num_removed = cart.remove 'ABC'
            expect(num_removed).to be 0
        end
    end


end
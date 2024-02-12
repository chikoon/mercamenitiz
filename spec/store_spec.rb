RSpec.describe Store, type: :class do

    before(:all){
        @product_1 = Product.new('AAA', 'AAA Batteries', '4.01')
        @product_2 = Product.new('ZZZ', 'ZZZ Sleeping Pills', '9.99')
        @invalid_product = Product.new('ZZZZ', '', '-1')
    }

    it "should have a name, a products array, and a cart instance" do
        { name: String, products: Array, cart: Cart }.each{|property, klass|
            store = Store.new("Test Store")
            expect(store.respond_to?(property)).to be true
            expect(store.send(property).is_a?(klass)).to be true
        }
        
    end

    context "adding products should" do
        before(:all){ @store = Store.new("Test Store") }

        it "fail when receiving anything but a valid product" do
            [nil, 'chicken', @invalid_product].each{|bad_product|
                expect { @store.add_product(bad_product) }.to raise_error(StandardError)
            }
        end

        it "add products successfully" do
            expect(@store.products.size).to be 0
            expect {
                @store.add_product @product_1
                @store.add_product @product_2
            }.not_to raise_error
            expect(@store.products.size).to be 2
        end

        it "not add duplicate products" do
            expect(@store.products.size).to be 2
            @store.add_product @product_1
            expect(@store.products.size).to be 2
        end
    end

    context "should return a list" do
        before(:all){
            @store = Store.new("Test Store")
            @store.add_product @product_1
            @store.add_product @product_2
        }

        it "of products" do
            expect(@store.products.size).to be 2
            expect(@store.products.first.class).to be Product
            expect(@store.product_list.size).to be 2
            expect(@store.product_list.first.class).to be String
            expect(@store.product_list.first).to eq(@store.products.first.to_s)
        end

        it "of existing product codes" do
            codes = @store.product_codes
            expect(codes.class).to be Array
            expect(codes.size).to be 2
            expect(codes.first.to_s).to eq('AAA')
        end
    end
    context "should search a product by code" do
        before(:all){
            @store = Store.new("Test Store")
            @store.add_product @product_1
        }

        it "and return a valid product" do
            product = @store.find_product('AAA')
            expect(product.is_a?(Product)).to be true
            expect(product.valid?).to be true
        end

        it "and fail when product is not found" do
            expect{
                product = @store.find_product('ABC')
            }.to raise_error(StandardError)
        end

        it "to see if the product exists" do
            expect(@store.product_exists?('AAA')).to be true
            expect(@store.product_exists?('ABC')).to be false
        end
    end


end
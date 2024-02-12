RSpec.describe Product, type: :class do

    describe 'creation' do 

        before(:all){
            @good_args_list = { # a list of good arguments
                price_float: ['AAA', 'AAA battery', 1.1111],
                prince_int:  ['AAA', 'AAA battery', 1],
                price_str_1: ['AAA', 'AAA battery', '1'],
                price_str_2: ['AAA', 'AAA battery', '1€'],
                price_str_3: ['AAA', 'AAA battery', '1.11€']
            }
        }

        context 'success' do
            it 'should return a product instance' do
                @good_args_list.each{|theme, argset|
                    expect { Product.new(*argset).validate! }.not_to raise_error
                }
            end
        end

        context 'fail unless it' do
            before(:each){
                @ok_args = @good_args_list.values.last
                @product = Product.new *@ok_args
            }

            it "has a-three letter uppercase product code" do
                [nil, '', 'a', 'ab', 'abc', 'ABCD'].each{|bad_value|
                    @product.code = bad_value
                    expect(@product.valid?).to be false
                    expect(@product.errors.keys.include?(:code)).to be true
                }
            end

            it "has a name" do
                [nil, ''].each{|bad_value|
                    @product.name = bad_value
                    expect(@product.valid?).to be false
                    expect(@product.errors.keys.include?(:name)).to be true
                }
            end

            it "has a numeric price greater than zero" do
                [nil, '', 'hello', '-1', -1, 0, '0.00', '0', '1,00€'].each{|bad_value|
                    @product.price = bad_value
                    expect(@product.valid?).to be false
                    expect(@product.errors.keys.include?(:price)).to be true
                }
            end

        end

    end

end
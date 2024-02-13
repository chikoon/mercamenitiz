RSpec.describe CLI, type: :class do

    let(:store) { Store.new('MercAmenitiz') }
    let(:cli) { described_class.new(store) }

    before(:each){
        store.add_product(Product.new("GR1", "Green Tea", 3.11))
        store.add_product(Product.new("SR1", "Strawberries", 5.00))
        store.add_product(Product.new("CF1", "Coffee", 11.23))
    }

    # [H] Show this option menu
    # [L] List products
    # [A] Add item to cart
    # [R] Remove item from cart
    # [C] Show cart contents
    # [X] Checkout
    # [Q] Quit

    context 'user should be able to' do

        it 'enter and exit' do
            allow(cli).to receive(:gets).and_return("Q")
            expect { cli.enter }.to output(/Welcome/).to_stdout
        end

        it 'see store name' do
            allow(cli).to receive(:gets).and_return("H", "Q")
            expect { cli.enter }.to output(/#{store.name}/).to_stdout
        end

        it 'view options/get help' do # [H] Show this option menu
            allow(cli).to receive(:gets).and_return("Q")
            expect { cli.enter }.to output(/#{"Option Menu"}/).to_stdout
        end

        it 'list products' do # [L] List products
            allow(cli).to receive(:gets).and_return("L", "Q")
            expect { cli.enter }.to output(/#{"Green Tea"}/).to_stdout
        end

        it 'add item to cart' do # [A] Add item to cart
            allow(cli).to receive(:gets).and_return("A", "GR1", "Q")
            expect { cli.enter }.to output(/Added.+#{"Green Tea"}/).to_stdout
        end

        it 'remove item from cart' do # [R] Remove item from cart
            allow(cli).to receive(:gets).and_return("A", "GR1", "R", "GR1", "Q")
            expect { cli.enter }.to output(/Removed.+#{"Green Tea"}/).to_stdout
        end

        it 'show cart contents' do # [C] Show cart contents
            allow(cli).to receive(:gets).and_return("A", "GR1", "C", "Q")
            expect { cli.enter }.to output(/Your Cart.+#{"Green Tea"}/m).to_stdout
        end

        it 'checkout' do # [X] Checkout
            allow(cli).to receive(:gets).and_return("A", "GR1", "X")
            expect { cli.enter }.to output(/Checkout.+#{"Green Tea"}/m).to_stdout
        end

        it 'quit at any time' do # [Q] Quit
            allow(cli).to receive(:gets).and_return("Q")
            expect { cli.enter }.not_to raise_error
        end
    end

end
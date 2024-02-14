RSpec.describe CLI, type: :class do

    let(:store) { Store.new('MercAmenitiz') }
    let(:cli) { described_class.new(store) }

    before(:each){
        [ ["GR1", "Green Tea", 3.11],
          ["SR1", "Strawberries", 5.00],
          ["CF1", "Coffee", 11.23]
        ].each{|args| store.add_product(Product.new(*args)) }

        [ TwoForOneTea,
          BulkStrawberries,
          BulkCoffee
        ].each{|promo| store.add_promo promo.new }
    }

    # [P] List products
    # [O] List available offers
    # [A] Add item to cart
    # [R] Remove item from cart
    # [C] Show cart contents
    # [X] Checkout
    # [Q] Quit
    # [H] Show this help

    describe 'user should be able to' do

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
            expect { cli.enter }.to output(/#{"Options Menu"}/).to_stdout
        end

        it 'list products' do # [L] List products
            allow(cli).to receive(:gets).and_return("P", "Q")
            expect { cli.enter }.to output(/#{"Green Tea"}/).to_stdout
        end

        it 'list promotional offers' do # [L] List products
            allow(cli).to receive(:gets).and_return("O", "Q")
            expect { cli.enter }.to output(/#{"Our Special Offers"}/).to_stdout
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

    describe 'checkout should' do
        let(:pricelist) {
            {
                GR1: store.find_product('GR1').price,
                SR1: store.find_product('SR1').price,
                CF1: store.find_product('CF1').price
            }
        }

        let(:sum){
            Proc.new{|*steps|
                codes = steps.select{|s| s.size == 3 }
                codes.collect{|c| pricelist[c.to_sym] }.inject(0, :+)
            }
        }

        it 'show a cumulative total' do
            steps = %w(A GR1 A SR1 A CF1 X)
            allow(cli).to receive(:gets).and_return(*steps)
            total = sprintf("%.2f", sum.call(*steps))
            expect { cli.enter }.to output(/TOTAL\:\s+#{total}€/).to_stdout
        end

        context 'correctly apply promotional discounts' do

            it 'Two for one sale on Green Tea' do
                steps = %w(A GR1 A GR1 A GR1 X)
                allow(cli).to receive(:gets).and_return(*steps)
                total = sprintf("%.2f", sum.call("GR1", "GR1"))
                expect { cli.enter }.to output(/TOTAL\:\s+#{total}€/).to_stdout
            end

            it 'Buy 3 or more strawberries, and pay only 4.50€ per unit' do
                steps = %w(A SR1 A SR1 A SR1 X)
                allow(cli).to receive(:gets).and_return(*steps)
                total = sprintf("%.2f", (4.5*3))
                expect { cli.enter }.to output(/TOTAL\:\s+#{total}€/).to_stdout
            end

            it 'Buy 3 or more coffee boxes, and pay 33% less per unit' do
                steps = %w(A CF1 A CF1 A CF1 X)
                allow(cli).to receive(:gets).and_return(*steps)
                unit_price = (pricelist[:CF1]/3)*2
                unit_count = steps.select{|s| s === 'CF1' }.size
                total = sprintf("%.2f", ( unit_price * unit_count ))
                expect { cli.enter }.to output(/TOTAL\:\s+#{total}€/).to_stdout
            end

        end

    end
end

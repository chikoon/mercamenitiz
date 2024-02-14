class TwoForOneTea < Promo

    def blurb; "Two for one sale on Green Tea"; end

    def check(items)
        teas = items.select { |i| i.code === "GR1" }
        teas.each_with_index do |tea, idx|
            if idx.odd?
                tea.price = 0
            end
        end
        teas.size > 1
    end

end

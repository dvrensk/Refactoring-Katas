require File.join(File.dirname(__FILE__), 'gilded_rose')


describe GildedRose do
  let(:item) { GildedRose.update_quality(items) ; items[0] }

  describe "#update_quality" do
    it "doesn't change name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.update_quality(items)
      items[0].name.should == "foo"
    end

    context "for normal goods" do
      let(:sell_in) { 3 }
      let(:quality) { 5 }
      let(:items) { [Item.new("foo", sell_in, quality)] }

      it "decreases quality" do
        item.quality.should == 4      
      end

      it "decreases sell_in" do
        item.sell_in.should == 2      
      end

      context "when quality is 0" do
        let(:quality) {0}
        it "never goes below 0" do
          item.quality.should == 0
        end
      end

      context "past sell-in date" do
        let(:sell_in) { 0 }
        it "decreases quality with double rate after last_sell" do
          item.quality.should == quality - 2
        end

        context "close to zero" do
          let(:quality) { 1 }
          it "decreases quality to 0 but not -1" do
            item.quality.should == 0
          end
        end
      end
      
    end

    context "Aged Brie" do
      let(:items) { [Item.new("Aged Brie", 10, 10)] }
      it "gets better with time" do
        item.quality.should == 11
      end

      context "past its sell-in date" do
        let(:items) { [Item.new("Aged Brie", 0, 10)] }
        it "gets better with time, twice as fast" do
          item.quality.should == 12
        end
      end
    end

    context "Sulfuras" do
      let(:sell_in) { 3 }
      let(:quality) { 80 }
      let(:items) { [Item.new("Sulfuras, Hand of Ragnaros", sell_in, quality)] }

      it "keeps quality" do
        item.quality.should == 80      
      end

      it "keeps sell_in" do
        item.sell_in.should == 3
      end
    end

    context "Backstage passes" do
      let(:quality) { 5 }
      let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality)] }

      context "with more than 10 days to the concert" do
        let(:sell_in) { 11 }

        it "increases quality slowly" do
          item.quality.should == 6
        end

        it "decreses sell_in" do
          item.sell_in.should == 10
        end
      end

      context "with 5-10 days to the concert" do
        let(:sell_in) { 6 }

        it "increases quality by two" do
          item.quality.should == quality + 2      
        end
      end

      context "with 5 days or less to the concert" do
        let(:sell_in) { 1 }

        it "increases quality by three" do
          item.quality.should == quality + 3 
        end
      end

      context "after the concert" do
        let(:sell_in) { 0 }
        it "decreses quality to 0" do
          item.quality.should == 0 
        end
      end

    end

    # context "Conjured items" do
    #   let(:sell_in) { 3 }
    #   let(:quality) { 30 }
    #   let(:items) { [Item.new("Conjured", sell_in, quality)] }

    #   it "decreases quality at double speed" do
    #     item.quality.should == 28
    #   end

    #   context "after sell-in date" do
    #     let(:sell_in) { 0 }

    #     it "decreases quality at double speed" do
    #       item.quality.should == 26
    #     end
    #   end
    # end

  end
  
end

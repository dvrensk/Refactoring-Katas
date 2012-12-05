require File.join(File.dirname(__FILE__), 'gilded_rose')


describe GildedRose do

  describe "#update_quality" do
    it "doesn't change name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.update_quality(items)
      items[0].name.should == "foo"
    end

    context "for normal goods" do
      let(:items) { [Item.new("foo", 3, 0)] }
      let(:item) { items[0] }

      it "decreases quality" do
        items = [Item.new("foo", 10, 5)]
        GildedRose.update_quality(items)
        items[0].quality.should == 4      
      end
      
      it "decreases quality with double rate after last_sell" do
        items = [Item.new("foo", 0, 5)]
        GildedRose.update_quality(items)
        items[0].quality.should == 3      
      end
      
      it "never goes below 0" do
        GildedRose.update_quality(items)

        item.quality.should == 0
      end
    end

    # context "Aged Brie" do
    #   let(:items) { [Item.new("Aged Brie", 10, 10)] }
    #   it "gets better with time" do
    #   end
    # end
  end
  
end

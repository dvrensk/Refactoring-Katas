require File.join(File.dirname(__FILE__), 'gilded_rose')


describe GildedRose do

  describe "#update_quality" do
    it "works" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new().update_quality(items)
      items[0].name.should == "apa"
    end
  end
    
end

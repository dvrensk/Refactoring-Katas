
class GildedRose

  def initialize(item)
    @item = item
  end
  attr_reader :item

  def self.update_quality(items)
    items.each do |item|
      thing = new(item)
      thing.adjust_all
      item.sell_in -= 1 unless item.name == "Sulfuras, Hand of Ragnaros"
      thing.adjust_past_sell_in if item.sell_in < 0
    end
    items
  end

  def better_with_time?
    item.name == "Aged Brie" or item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def adjust_all
    if better_with_time?
      increase_quality if item.quality < 50
    else
      decrease_quality if item.quality > 0
    end
  end

  def adjust_past_sell_in
    if item.name == "Aged Brie"
      item.quality += 1 if item.quality < 50
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      item.quality = 0
    else
      decrease_quality if item.quality > 0
    end
  end

  def increase_quality
    item.quality += 1
    if item.name == "Backstage passes to a TAFKAL80ETC concert"
      if item.sell_in < 11
        if item.quality < 50
          item.quality += 1
        end
      end
      if item.sell_in < 6
        if item.quality < 50
          item.quality += 1
        end
      end
    end
  end

  def decrease_quality
    item.quality -= 1 unless item.name == "Sulfuras, Hand of Ragnaros"
    item.quality -= 1 if item.name == "Conjured"
  end

end

class Item
  attr_accessor :name, :sell_in, :quality
  
  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end   
  
  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
        


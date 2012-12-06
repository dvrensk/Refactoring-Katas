
class GildedRose
  def self.update_quality(items)
    items.each do |i|
      item = wrap(i)
      item.run
      i.sell_in, i.quality = item.sell_in, item.quality
    end
  end

  def self.wrap(i)
    klass = case i.name
            when /^Sulfuras/       then Sulfuras
            when /\bBrie\b/        then Cheese
            when /^Backstage pass/ then Ticket
            else Item
            end
    klass.new(i.sell_in, i.quality)
  end

  class Item < Struct.new(:sell_in, :quality)
    def run
      self.sell_in -= 1
      if quality > 0
        self.quality -= (sell_in < 0 ? 2 : 1)
      end
    end
  end

  class Sulfuras < Item
    def run ; end
  end

  class Cheese < Item
    def run
      self.sell_in -= 1
      self.quality += sell_in < 0 ? 2 : 1
    end
  end

  class Ticket < Item
    def run
      self.sell_in -= 1
      if sell_in < 0
        self.quality = 0
      else
        self.quality += case sell_in
                        when 5...10 then 2
                        when 0...5  then 3
                        else 1
                        end
      end
    end
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
        


class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name == "Sulfuras, Hand of Ragnaros"
        sulfuras
      elsif item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert"
        default_item(item)
      else

        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end

        item.sell_in = item.sell_in - 1

        if item.sell_in < 0
          if item.name != "Aged Brie"
            item.quality = item.quality - item.quality
          else
            if item.quality < 50
              item.quality = item.quality + 1
            end
          end
        end
      end
    end
  end

  def sulfuras
  end

  def default_item(item)
    if item.quality > 0
      item.quality -= 1
      item.sell_in -= 1
      item.quality -= 1 if item.sell_in < 0
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

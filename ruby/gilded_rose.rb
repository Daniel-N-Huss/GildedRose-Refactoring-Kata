class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name == "Sulfuras, Hand of Ragnaros"
        sulfuras
      elsif item.name == "Aged Brie"
        brie(item)
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        backstage(item)
      else
        default_item(item)
      end
    end
  end

  def sulfuras
  end

  def default_item(item)
    item.quality -= 1
    item.sell_in -= 1
    item.quality -= 1 if item.sell_in < 0
    item.quality = 0 if item.quality < 0
  end

  def backstage(item)
    item.sell_in -= 1

    if item.sell_in < 0
      item.quality = 0
    else
      item.quality += 1 if item.quality < 50
      item.quality += 1 if item.sell_in < 11 && item.quality < 50
      item.quality += 1 if item.sell_in < 6 && item.quality < 50
    end
  end

  def brie(item)
    item.quality += 1 if item.quality < 50

    item.sell_in = item.sell_in - 1

    if item.sell_in < 0
      item.quality += 1 if item.quality < 50
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

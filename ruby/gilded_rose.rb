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
    item.decrease_quality
    item.decrease_sell_in
    item.decrease_quality if item.sell_in < 0
  end

  def backstage(item)
    item.decrease_sell_in

    if item.sell_in < 0
      item.quality = 0
    else
      item.increase_quality
      item.increase_quality if item.sell_in < 11
      item.increase_quality if item.sell_in < 6
    end
  end

  def brie(item)
    item.increase_quality
    item.decrease_sell_in
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

  def decrease_sell_in
    @sell_in -= 1
  end

  def decrease_quality
    @quality -= 1 if @quality > 0
  end

  def increase_quality
    @quality += 1 if @quality < 50
  end
end

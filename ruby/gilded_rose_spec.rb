require File.join(File.dirname(__FILE__), 'gilded_rose')
require "rspec"

RSpec.describe GildedRose do

  describe "#update_quality" do
    sulfuras = "Sulfuras, Hand of Ragnaros"

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq "foo"
    end

    describe 'sell_in' do
      context 'item is Sulfuras' do
        it 'does not change sell_in' do
          sell_in = 10
          items = [Item.new(sulfuras, sell_in, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq sell_in
        end
      end
      context 'item is not Sulfuras' do
        it 'decrements sell_in by 1' do
          sell_in = 10
          items = [Item.new("NotSulfuras", sell_in, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(sell_in - 1)
        end

      end
    end
  end

end

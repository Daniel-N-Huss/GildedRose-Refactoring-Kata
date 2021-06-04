require File.join(File.dirname(__FILE__), 'gilded_rose')
require "rspec"

RSpec.describe GildedRose do

  describe "#update_quality" do
    subject { described_class.new(items).update_quality }

    context 'item is Sulfuras' do
      let(:sell_in) { 10 }
      let(:quality) { 80 }
      let(:sulfuras) { Item.new("Sulfuras, Hand of Ragnaros", sell_in, quality) }
      let(:items) { [sulfuras] }

      it 'does not change sell_in' do
        expect { subject }.not_to change { sulfuras.sell_in }
      end

      it 'does not change quality' do
        expect { subject }.not_to change { sulfuras.quality }
      end
    end

    let(:backstage) { Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality) }
    let(:brie) { Item.new("Aged Brie", sell_in, quality) }
  end
end

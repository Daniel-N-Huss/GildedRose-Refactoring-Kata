require File.join(File.dirname(__FILE__), 'gilded_rose')
require "rspec"

RSpec.describe GildedRose do

  describe "#update_quality" do
    let(:sulfuras) { Item.new("Sulfuras, Hand of Ragnaros", 0, 80) }
    let(:backstage) { "Backstage passes to a TAFKAL80ETC concert" }
    let(:brie) { "Aged Brie" }

    let(:items) { [Item.new("foo", 0, 0)] }

    subject { described_class.new(items).update_quality }

    it "does not change the name" do
      subject
      expect(items[0].name).to eq "foo"
    end

    describe 'sell_in' do
      context 'item is Sulfuras' do
        let(:items) { [sulfuras] }

        it 'does not change sell_in' do
          subject
          expect(items[0].sell_in).to eq 0
        end
      end
      context 'item is not Sulfuras' do
        let(:sell_in) { 10 }
        let(:items) { [Item.new("NotSulfuras", sell_in, 0)] }

        it 'decrements sell_in by 1' do
          subject
          expect(items[0].sell_in).to eq(sell_in - 1)
        end
      end
    end

    describe 'quality' do
      describe 'quality is 50 or above' do
        let(:items) { [sulfuras] }

        it 'does not increase quality' do

        end

      end
    end
  end
end

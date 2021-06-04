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

    context 'item is Backstage passes' do
      let(:backstage) { Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality) }
      let(:sell_in) { 15 }
      let(:quality) { 25 }
      let(:items) { [backstage] }

      it 'decrements sell_in' do
        expect { subject }.to change { backstage.sell_in }.by(-1)
      end

      context 'when sell_in is less than 10' do
        let(:sell_in) { 9 }

        it 'increases quality by 2' do
          expect { subject }.to change { backstage.quality }.by(2)
        end
      end

      context 'when sell_in is less than 5' do
        let(:sell_in) { 3 }

        it 'increases quality by 3' do
          expect { subject }.to change { backstage.quality }.by(3)
        end
      end

      context 'when sell_in is a negative number' do
        let(:sell_in) { -1 }

        it 'sets quality is 0' do
          subject
          expect(backstage.quality).to be 0
        end
      end

      context 'when quality is below 50' do
        let(:quality) { 25 }

        it 'increases quality' do
          expect { subject }.to change { backstage.quality }.by(1)
        end
      end

      context 'when quality is at 50' do
        let(:quality) { 50 }

        it 'does not increase quality' do
          expect { subject }.not_to change { backstage.quality }
        end
      end
    end

    context 'item is Brie' do
      let(:brie) { Item.new("Aged Brie", sell_in, quality) }
      let(:sell_in) { 10 }
      let(:quality) { 25 }
      let(:items) { [brie] }

      it 'decrements sell_in' do
        expect { subject }.to change { brie.sell_in }.by(-1)
      end

      context 'when quality is below 50' do
        let(:quality) { 25 }

        it 'increases quality' do
          expect { subject }.to change { brie.quality }.by(1)
        end
      end

      context 'when quality is at 50' do
        let(:quality) { 50 }

        it 'does not increase quality' do
          expect { subject }.not_to change { brie.quality }
        end
      end
    end

    context 'item is Conjured Mana Cake' do
    end

    context 'any other items' do
    end

  end
end

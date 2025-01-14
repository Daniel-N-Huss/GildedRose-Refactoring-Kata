require File.join(File.dirname(__FILE__), 'gilded_rose')
require "rspec"

RSpec.describe GildedRose do

  describe "#update_quality" do
    subject { described_class.new([item]).update_quality }

    context 'item is Sulfuras' do
      let(:sell_in) { 10 }
      let(:quality) { 80 }
      let(:item) { Item.new("Sulfuras, Hand of Ragnaros", sell_in, quality) }

      it 'does not change sell_in' do
        expect { subject }.not_to change { item.sell_in }
      end

      it 'does not change quality' do
        expect { subject }.not_to change { item.quality }
      end
    end

    context 'item is Backstage passes' do
      let(:item) { Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality) }
      let(:sell_in) { 15 }
      let(:quality) { 25 }

      it 'decrements sell_in' do
        expect { subject }.to change { item.sell_in }.by(-1)
      end

      context 'when sell_in is 10 or less' do
        let(:sell_in) { 9 }

        it 'increases quality by 2' do
          expect { subject }.to change { item.quality }.by(2)
        end
      end

      context 'when sell_in is 5 or less' do
        let(:sell_in) { 3 }

        it 'increases quality by 3' do
          expect { subject }.to change { item.quality }.by(3)
        end
      end

      context 'when sell_in is a negative number' do
        let(:sell_in) { -1 }

        it 'sets quality is 0' do
          subject
          expect(item.quality).to be 0
        end
      end

      context 'when quality is below 50' do
        let(:quality) { 25 }

        it 'increases quality' do
          expect { subject }.to change { item.quality }.by(1)
        end
      end

      context 'when quality is at 50' do
        let(:quality) { 50 }

        it 'does not increase quality' do
          expect { subject }.not_to change { item.quality }
        end
      end
    end

    context 'item is Brie' do
      let(:item) { Item.new("Aged Brie", sell_in, quality) }
      let(:sell_in) { 10 }
      let(:quality) { 25 }

      it 'decrements sell_in' do
        expect { subject }.to change { item.sell_in }.by(-1)
      end

      context 'when quality is below 50' do
        let(:quality) { 25 }

        it 'increases quality' do
          expect { subject }.to change { item.quality }.by(1)
        end
      end

      context 'when quality is at 50' do
        let(:quality) { 50 }

        it 'does not increase quality' do
          expect { subject }.not_to change { item.quality }
        end
      end
    end

    context 'item is Conjured Mana Cake' do
      let(:item) { Item.new("Conjured Mana Cake", sell_in, quality) }
      let(:sell_in) { 10 }
      let(:quality) { 25 }

      it 'decrements sell_in' do
        expect { subject }.to change { item.sell_in }.by(-1)
      end

      context 'when quality is above 0' do
        let(:quality) { 25 }

        context 'when sell_in is positive' do
          let(:sell_in) { 10 }

          it 'decrements quality by 2' do
            expect { subject }.to change { item.quality }.by(-2)
          end
        end

        context 'when sell_in is negative' do
          let(:sell_in) { -1 }

          it 'decrements quality by 2' do
            expect { subject }.to change { item.quality }.by(-4)
          end
        end
      end

      context 'when quality is at 0' do
        let(:quality) { 0 }

        it 'does not decrease quality' do
          expect { subject }.not_to change { item.quality }
        end
      end
    end

    context 'any other items' do
      let(:item) { Item.new("Initiates Staff", sell_in, quality) }
      let(:sell_in) { 10 }
      let(:quality) { 25 }

      it 'decrements sell_in' do
        expect { subject }.to change { item.sell_in }.by(-1)
      end

      context 'when quality is above 0' do
        let(:quality) { 25 }

        context 'when sell_in is positive' do
          let(:sell_in) { 10 }

          it 'decrements quality by 1' do
            expect { subject }.to change { item.quality }.by(-1)
          end
        end

        context 'when sell_in is negative' do
          let(:sell_in) { -1 }

          it 'decrements quality by 2' do
            expect { subject }.to change { item.quality }.by(-2)
          end
        end
      end

      context 'when quality is at 0' do
        let(:quality) { 0 }

        it 'does not decrease quality' do
          expect { subject }.not_to change { item.quality }
        end
      end
    end

  end
end

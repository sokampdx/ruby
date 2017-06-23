require 'rspec'

class Supermarket
  def add_item(item_price)
    @item_price = item_price
  end

  def invalid?(item)
    @item_price.nil? || @item_price[item].nil?
  end

  def price(item, unit)
    raise ItemNotFound if invalid?(item)
    a_item = @item_price[item]
    a_item[:price] * unit / a_item[:unit].to_f
  end
end

class ItemNotFound < Exception
end

describe Supermarket do
  let(:supermarket) { Supermarket.new }

  it 'create a new supermarket' do
    expect(supermarket).to be_truthy
  end

  it 'returns an error if there is nothing listed' do
    expect do
      supermarket.price('can of soup', 1)
    end.to raise_error(ItemNotFound)
  end

  context 'when item added to supermarket' do
    let(:pricing) do
      { 
        'can of soup' => { unit: 1, price: 1},
        'can of tuna' => { unit: 3, price: 5},
        'chicken' => { unit: 1, price: 20 }
      }
    end

    before(:each) { supermarket.add_item(pricing) }

    it 'returns an error if item is not in the list' do
      expect do
        supermarket.price('can of peas', 1)
      end.to raise_error(ItemNotFound)
    end 

    it 'prices discrete item on unit item return unit price' do
      expect(supermarket.price('can of soup', 1)).to eq(1)
    end

    it 'prices discrete item on correctly given multiple of unit price' do
      expect(supermarket.price('can of soup', 2)).to eq(2)
      expect(supermarket.price('can of tuna', 3)).to eq(5)
    end 

    it 'prcies discrete item on less than the listed unit' do
      expect(supermarket.price('can of tuna', 1)).to be_within(0.001).of(5.0/3)
      expect(supermarket.price('chicken', 0.1)).to be_within(0.001).of(2)
    end
  end
end

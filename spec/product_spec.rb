# frozen_string_literal: true

require 'product'

test_product = {
  'productId' => 1,
  'description' => 'Small Widget',
  'quantityOnHand' => 50,
  'reorderThreshold' => 10,
  'reorderAmount' => 50,
  'deliveryLeadTime' => 5
}

RSpec.describe NOMSS::Product, '#item_can_be_fulfilled' do
  it 'can be fulfilled given amount less than stock on hand' do
    product = NOMSS::Product.new(test_product)
    expect(product.item_can_be_fulfilled(20)).to eq true
  end
  it 'can be fulfilled given exact amount of stock on hand' do
    product = NOMSS::Product.new(test_product)
    expect(product.item_can_be_fulfilled(50)).to eq true
  end
  it 'cannot be fulfilled given more than amount of stock on hand' do
    product = NOMSS::Product.new(test_product)
    expect(product.item_can_be_fulfilled(51)).to eq false
  end
end

RSpec.describe NOMSS::Product, '#sell' do
  it 'sells product and lowers stock on hand' do
    product = NOMSS::Product.new(test_product)
    product.sell(20)
    expect(product.quantity_on_hand).to eq 30
  end
  it 'raises error if there is not enough stock on hand' do
    product = NOMSS::Product.new(test_product)
    expect { product.sell(51) }.to raise_error
  end
end

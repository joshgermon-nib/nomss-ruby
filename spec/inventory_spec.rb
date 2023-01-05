# frozen_string_literal: true

require 'inventory'
require 'product'

products = [
  {
    'productId' => 1,
    'description' => 'Small Widget',
    'quantityOnHand' => 50,
    'reorderThreshold' => 10,
    'reorderAmount' => 50,
    'deliveryLeadTime' => 5
  },
  {
    'productId' => 2,
    'description' => 'Medium Widget',
    'quantityOnHand' => 10,
    'reorderThreshold' => 10,
    'reorderAmount' => 10,
    'deliveryLeadTime' => 5
  },
  {
    'productId' => 3,
    'description' => 'Large Widget',
    'quantityOnHand' => 0,
    'reorderThreshold' => 10,
    'reorderAmount' => 20,
    'deliveryLeadTime' => 5
  }
]

RSpec.describe NOMSS::Inventory, '#create_product_table' do
  it 'creates a hash of products using product_id as the key' do
    inventory = NOMSS::Inventory.new(products)
    product_hash = inventory.create_product_table(products)
    expect(product_hash.count).to eq 3
    expect(product_hash[1]).to be_a NOMSS::Product
    expect(product_hash[2].description).to eq 'Medium Widget'
  end
end

RSpec.describe NOMSS::Inventory, '#get_product' do
  it 'creates product hash and retrieves it' do
    inventory = NOMSS::Inventory.new(products)
    product = inventory.get_product(1)
    expect(product).to be_a NOMSS::Product
    expect(product.description).to eq 'Small Widget'
  end
end

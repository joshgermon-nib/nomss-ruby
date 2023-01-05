require 'order'
require 'inventory'

test_order = {
  'orderId' => 1,
  'status' => 'Pending',
  'dateCreated' => 50,
  'items' => [
    {
      'orderId' => 1122,
      'productId' => 1,
      'quantity' => 5,
      'costPerItem' => 24.95
    },
    {
      'orderId' => 1122,
      'productId' => 2,
      'quantity' => 5,
      'costPerItem' => 24.95
    }
  ]
}

test_inventory = [
  {
    'productId' => 1,
    'description' => 'Small Widget',
    'quantityOnHand' => 10,
    'reorderThreshold' => 10,
    'reorderAmount' => 50,
    'deliveryLeadTime' => 5
  },
  {
    'productId' => 2,
    'description' => 'Medium Widget',
    'quantityOnHand' => 5,
    'reorderThreshold' => 10,
    'reorderAmount' => 50,
    'deliveryLeadTime' => 5
  },
  {
    'productId' => 3,
    'description' => 'Large Widget',
    'quantityOnHand' => 0,
    'reorderThreshold' => 10,
    'reorderAmount' => 50,
    'deliveryLeadTime' => 5
  }
]

RSpec.describe NOMSS::Order, '#process' do
  it 'processes order items and ensures all items are fulfillable' do
    inventory = NOMSS::Inventory.new(test_inventory)
    order = NOMSS::Order.new(test_order)
    expect(order.process(inventory)).to eq true
  end
end

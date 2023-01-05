# frozen_string_literal: true

RSpec.describe NOMSS do
  it "has a version number" do
    expect(NOMSS::VERSION).not_to be nil
  end
end

RSpec.describe NOMSS::OrderManagementSystem, '#process_orders' do
  it "processes all orders and returns unfulfilable orders" do
    order_manager = NOMSS::OrderManagementSystem.new
    expect(order_manager.process_orders([1122, 1123, 1124, 1125])).to eq([1123, 1125])
  end
  it "process a single fulfillable order and returns an empty array" do
    order_manager = NOMSS::OrderManagementSystem.new
    expect(order_manager.process_orders([1122])).to eq([])
  end
end

# RSpec.describe NOMSS::OrderManagementSystem, '#create_product_table' do
#   it 'creates a hash of products using product_id as the key' do
#     order_manager = NOMSS::OrderManagementSystem.new
#   end
# end

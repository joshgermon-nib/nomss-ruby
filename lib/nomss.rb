# frozen_string_literal: true

require_relative "nomss/version"
require 'json'
require_relative 'inventory'
require_relative 'order'

module NOMSS
  class Error < StandardError; end

  class OrderManagementSystem
    def initialize
      # read in json data
      path = File.expand_path('../data.json', __dir__)
      @data = JSON.parse(File.read(path))
      @inventory = Inventory.new @data['products']
      @orders = create_orders_table @data['orders']
    end

    def create_orders_table(orders)
      orders.map { |order| [order['orderId'], Order.new(order)] }.to_h
    end

    def process_orders(order_ids)
      unfulfilable_orders = Array.new
      order_ids.each do |id|
        order_fulfilled = @orders[id].process(@inventory)
        unfulfilable_orders.push(id) unless order_fulfilled
      end
      return unfulfilable_orders
    end
  end

  order_manager = OrderManagementSystem.new
  order_manager.process_orders([1122, 1123])
end

# frozen_string_literal: true

module NOMSS
  class Order
    def initialize(order)
      @id = order['orderId']
      @status = order['status']
      @date_created = order['dateCreated']
      @items = order['items'].map { |item| OrderItem.new item }
    end

    def process(inventory)
      # process the order
      puts "Commencing processing of Order #{@id}..."
      return false unless @items.all? { |i| i.fulfillable(inventory) } == true

      @items.each { |i| i.process(inventory) }
      puts "Order ##{@id} processed."
      return true
    end
  end

  class OrderItem
    def initialize(item)
      @order_id = item['orderId']
      @product_id = item['productId']
      @quantity = item['quantity']
      @cost_per_item = item['costPerItem']
    end

    def process(inventory)
      product = inventory.get_product(@product_id)
      product.sell(@quantity)
    end

    def fulfillable(inventory)
      product = inventory.get_product(@product_id)
      product.item_can_be_fulfilled(@quantity)
    end
  end
end

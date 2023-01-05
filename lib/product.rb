# frozen_string_literal: true

module NOMSS
  class Product
    attr_reader :id, :description, :quantity_on_hand

    def initialize(product)
      @id = product['productId']
      @description = product['description']
      @quantity_on_hand = product['quantityOnHand']
      @reorder_threshold = product['reorderThreshold']
      @reorder_amount = product['reorderAmount']
      @delivery_lead_time = product['deliveryLeadTime']
    end

    def item_can_be_fulfilled(quantity)
      @quantity_on_hand - quantity >= 0
    end

    def sell(quantity)
      raise 'Unable to sell item as it would exceed quantity on hand.' unless item_can_be_fulfilled(quantity)

      @quantity_on_hand -= quantity
      reorder_stock if @quantity_on_hand <= @reorder_threshold
    end

    def reorder_stock
      puts "Reordering #{@reorder_amount} of product ##{@id}"
    end
  end
end

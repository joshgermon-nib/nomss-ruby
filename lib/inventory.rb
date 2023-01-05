# frozen_string_literal: true

require_relative 'product'

module NOMSS
  class Inventory
    def initialize(products)
      @products = create_product_table(products)
    end

    def create_product_table(products)
      products.map { |product| [product['productId'], Product.new(product)] }.to_h
    end

    def get_product(id)
      @products[id]
    end
  end
end

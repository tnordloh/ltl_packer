# frozen_string_literal: true

module LtlPacker
  # A truck, that can be loaded, and report on itself
  class Truck
    def initialize(id, size, shipments = [])
      @id = id.freeze
      @size = size.freeze
      @shipments = shipments
    end
    attr_accessor :shipments
    attr_reader :size, :id

    def load(shipment)
      @shipments << shipment
    end

    def clone
      self.class.new(id, size, shipments.map(&:clone))
    end

    def total_shipment_size
      shipments.map(&:capacity).sum
    end

    def capacity
      size - total_shipment_size
    end

    def shipment_count
      shipments.count
    end
  end
end

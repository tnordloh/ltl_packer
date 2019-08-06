#! /usr/bin/env ruby
# frozen_string_literal: true

require 'ltl_packer'
require_relative 'data'

trucks = @trucks.map { |truck| truck = LtlPacker::Truck.new(*truck.to_a) }
shipments = @shipments.map { |shipment| shipment = LtlPacker::Shipment.new(*shipment.to_a) }
loader = LtlPacker::Loader.new(trucks: trucks.map(&:clone), shipments: shipments.map(&:clone))

def best_fit_decreasing(loader)
  until loader.done?
    biggest_shipment = loader.biggest_shipment
    truck = loader.best_fitting_truck(biggest_shipment)
    loader = loader.load(truck.id, biggest_shipment.id)
  end
  loader
end
puts "*" * 100
puts "largest shipment, in the truck where it fits best"
finished_loader = best_fit_decreasing(loader)
finished_loader.report
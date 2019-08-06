#! /usr/bin/env ruby
# frozen_string_literal: true

require 'ltl_packer'
require_relative 'data'

trucks = @trucks.map { |truck| truck = LtlPacker::Truck.new(*truck.to_a) }
shipments = @shipments.map { |shipment| shipment = LtlPacker::Shipment.new(*shipment.to_a) }
loader = LtlPacker::Loader.new(trucks: trucks, shipments: shipments)

def best_fit_decreasing_combinations(loader)
  until loader.done?
    truck = loader.smallest_truck
    shipments = loader.shipments
    combinations = shipments.combination(1).to_a + shipments.combination(2).to_a
    ########
    #comment/uncomment the below line, to swap between favoring more even loads with maximum space usage
    ########
    #combinations.sort! { |a, b| [b.size, b.map(&:capacity).sum] <=> [a.size, a.map(&:capacity).sum] }
    combinations.sort! { |a, b| [b.map(&:capacity).sum, b.size ] <=> [a.map(&:capacity).sum, a.size] }
    #combinations.sort! { |a, b| [b.map(&:capacity).sum, a.size ] <=> [a.map(&:capacity).sum, b.size] }
    best_combination = combinations.find { |c| c.map(&:capacity).sum <= truck.capacity }
    best_combination.each { |c| loader = loader.load(truck.id, c.id) }
  end
  loader
end
finished_loader = best_fit_decreasing_combinations(loader)
finished_loader.report

#! /usr/bin/env ruby
# frozen_string_literal: true

require 'ltl_packer'
require_relative 'data'

trucks = @trucks.map { |truck| truck = LtlPacker::Truck.new(*truck.to_a) }
shipments = @shipments.map { |shipment| shipment = LtlPacker::Shipment.new(*shipment.to_a) }
loader = LtlPacker::Loader.new(trucks: trucks.map(&:clone), shipments: shipments.map(&:clone))
unsolved = [ loader ]
solved = []

@stop = false
until unsolved.empty?# ||  solved.size >= 10_000 do
  current = unsolved.pop
  truck = current.least_routes.first
  shipments_that_fit = current.shipments_that_fit(truck)
  shipments_that_fit.each do |shipment|
    new_solver = current.load(truck.id, shipment.id)
    new_solver.done? ? solved << new_solver : unsolved << new_solver
  end
end

# select loader dockets where shipments differ by no more than 1
balanced_shipments = solved.select do |this_solution|
  shipment_counts = this_solution.trucks.map(&:shipment_count) 
  shipment_counts.max - shipment_counts.min <= 1
end
# select docket that results in the most shipments
best = balanced_shipments.sort { |a, b| a.shipments.count <=> b.shipments.count } 
       .min_by {|s| s.unshipped_capacity }
puts "*" * 100
best.report

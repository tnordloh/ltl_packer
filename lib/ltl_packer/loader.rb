# frozen_string_literal: true

module LtlPacker
  # A class to put shipments onto trucks
  class Loader
    def initialize(trucks: [], shipments: [])
      @trucks = [trucks].flatten
      @shipments = [shipments].flatten
    end

    def trucks
      @trucks.sort_by(&:capacity)
    end

    def shipments
      @shipments.sort_by(&:capacity)
    end

    def load(truck, shipment)
      truck_id = truck.is_a?(LtlPacker::Truck) ? truck.id : truck
      shipment_id = shipment.is_a?(LtlPacker::Shipment) ? shipment.id : shipment
      new_trucks = trucks.map(&:clone)
      truck = new_trucks.find { |t| t.id == truck_id }
      new_shipments = shipments.map(&:clone)
      index = shipments.find_index { |s| s.id == shipment_id }
      shipment = new_shipments.find { |s| s.id == shipment_id }
      if truck.capacity < shipment.capacity
        raise ArgumentError, "shipment doesn't fit"
      end

      s = new_shipments.delete_at(index)
      truck.load(s)
      self.class.new(trucks: new_trucks, shipments: new_shipments)
    end

    def unshipped_capacity
      shipments.map(&:capacity).sum
    end

    def wasted_truck_space
      trucks.map(&:capacity).sum
    end

    def done?
      biggest_truck.capacity < shipments.first.capacity
    end

    def least_routes
      trucks_with_space.sort_by do |truck|
        [truck.shipments.count, truck.capacity]
      end
    end

    def biggest_truck
      trucks.reverse.first
    end

    def shipments_that_fit(truck)
      shipments.select { |shipment| shipment.capacity <= truck.capacity }
    end

    def trucks_with_space
      trucks.select { |truck| truck.capacity >= shipments.first.capacity }
    end

    def smallest_truck
      trucks_with_space.first
    end

    def best_fitting_truck(shipment)
      trucks.find { |t| t.capacity >= shipment.capacity }
    end

    def biggest_shipment(truck: nil)
      truck ||= biggest_truck
      shipments_that_fit(truck).reverse.first
    end

    def report
      puts "total # of shipments loaded #{trucks.map(&:shipment_count).sum}"
      shipment_report =  'shipments not loaded ' \
                         "#{shipments.map(&:id).join(',')}, " \
                         "(#{unshipped_capacity}) total capacity not loaded)"
      puts shipment_report
      puts 'shipment count per truck'
      trucks.each do |truck|
        puts "truck #{truck.id}: #{truck.shipment_count}" \
             " (#{truck.shipments.map(&:id).join(',')}), #{truck.capacity}"
      end
      puts "unused space on trucks #{wasted_truck_space}"
    end
  end
end

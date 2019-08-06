# frozen_string_literal: true
require "test_helper"

describe LtlPacker::Loader do
  let(:truck) { LtlPacker::Truck.new("001", 44_000) }
  let(:shipment) { LtlPacker::Shipment.new("001", 16_000) }
  let(:loader) { LtlPacker::Loader.new(trucks: [truck], shipments: [shipment]) }

  it "can load a truck" do
    this_loader = loader.load(truck.id,shipment.id)
    this_loader.trucks.first.capacity.must_equal(44_000 - 16_000)
  end

  it "raises_an_error_if_shipment_is_too_big" do
    bigger_shipment = LtlPacker::Shipment.new("x", 9_000_000)
    ltl_loader = LtlPacker::Loader.new(trucks: [truck], shipments: [bigger_shipment])
    -> do 
      ltl_loader.load(truck.id,bigger_shipment.id)
    end.must_raise ArgumentError
  end
  it "can calculate wasted truck space" do
    this_loader = loader.load(loader.trucks.first,loader.shipments.first)
    assert this_loader.wasted_truck_space == truck.capacity - shipment.capacity
    #assert loader.done? == true
  end
  it "can calculate unshipped capacity" do
    assert loader.unshipped_capacity == shipment.capacity
  end
end
class LtlPackerTest < Minitest::Test

  def test_it_can_pick_a_random_truck_and_shipment
    truck = LtlPacker::Truck.new("001", 44_000)
    shipment = LtlPacker::Shipment.new("001", 16_000)
    loader = LtlPacker::Loader.new(trucks: [truck], shipments: [shipment])
    loader = loader.load(loader.trucks.sample,loader.shipments.sample)
    assert loader.trucks.first.capacity == 44_000 - 16_000
  end

  def test_it_can_pick_the_smallest_truck_and_biggest_shipment
    trucks =  [ LtlPacker::Truck.new("001", 44_000) ]
    trucks << LtlPacker::Truck.new("002", 42_000)
    shipments = [ LtlPacker::Shipment.new("001", 16_000) ]
    shipments << LtlPacker::Shipment.new("002", 14_000)
    loader = LtlPacker::Loader.new(trucks: trucks, shipments: shipments)
    assert loader.smallest_truck.capacity == 42_000
    assert loader.biggest_shipment.capacity == 16_000
  end

end

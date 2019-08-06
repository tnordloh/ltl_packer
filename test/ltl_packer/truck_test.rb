# frozen_string_literal: true
require "test_helper"

class LtlPackerTest < Minitest::Test
  def test_it_can_build_a_truck
    truck = LtlPacker::Truck.new(1, 1_000)
    assert truck.id == 1
    assert truck.capacity == 1_000
  end

  def test_it_can_calculate_capacity
    truck = LtlPacker::Truck.new(1, 1_000)
    cargo = LtlPacker::Shipment.new(1, 100)
    truck.load(cargo)
    assert truck.capacity == 900
  end
end

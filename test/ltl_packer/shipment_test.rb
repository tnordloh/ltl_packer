# frozen_string_literal: true
require "test_helper"

class LtlPackerTest < Minitest::Test
  def test_it_can_build_a_shipment
    shipment = LtlPacker::Shipment.new(1, 1_000)
    assert shipment.id == 1
    assert shipment.capacity == 1_000
  end
end

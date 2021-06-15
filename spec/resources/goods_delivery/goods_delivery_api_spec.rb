require 'spec_helper'

describe Eol::GoodsDelivery do
  it "can initialize" do
    GoodsDelivery = Eol::GoodsDelivery.new
    expect(GoodsDelivery).to be_a(Eol::GoodsDelivery)
  end

  it "accepts attribute setter" do
    GoodsDelivery = Eol::GoodsDelivery.new
    GoodsDelivery.tracking_number = "9999 9999 9999"
    expect(GoodsDelivery.tracking_number).to eq "9999 9999 9999"
  end

  it "returns value for getters" do
    GoodsDelivery = Eol::GoodsDelivery.new({ tracking_number: "9999 9999 9999" })
    expect(GoodsDelivery.tracking_number).to eq "9999 9999 9999"
  end

  it "crashes and burns when getting an unset attribute" do
    GoodsDelivery = Eol::GoodsDelivery.new({ tracking_number: "9999 9999 9999" })
    expect(GoodsDelivery.try(:shipping_method_code)).to eq nil
  end

  it "does not allow to set an invalid attribute" do
    GoodsDelivery = Eol::GoodsDelivery.new
    GoodsDelivery.airplane = "Boeing 777"
    expect(GoodsDelivery.airplaine).to eq nil
  end
end

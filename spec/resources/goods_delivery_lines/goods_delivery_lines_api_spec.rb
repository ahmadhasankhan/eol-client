require 'spec_helper'

describe Eol::GoodsDeliveryLine do
  it "can initialize" do
    GoodsDeliveryLine = Eol::GoodsDeliveryLine.new
    expect(GoodsDeliveryLine).to be_a(Eol::GoodsDeliveryLine)
  end

  it "accepts attribute setter" do
    GoodsDeliveryLine = Eol::GoodsDeliveryLine.new
    GoodsDeliveryLine.tracking_number = "9999 9999 9999"
    expect(GoodsDeliveryLine.tracking_number).to eq "9999 9999 9999"
  end

  it "returns value for getters" do
    GoodsDeliveryLine = Eol::GoodsDeliveryLine.new({ tracking_number: "9999 9999 9999" })
    expect(GoodsDeliveryLine.tracking_number).to eq "9999 9999 9999"
  end

end

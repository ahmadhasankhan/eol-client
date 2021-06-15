require 'spec_helper'

describe Eol::AgingReceivablesList do
  it "can initialize" do
    sales_invoice = Eol::AgingReceivablesList.new
    expect(sales_invoice).to be_a(Eol::AgingReceivablesList)
  end

  it "is valid without attributes" do
    sales_invoice = Eol::AgingReceivablesList.new
    expect(sales_invoice.valid?).to eq(true)
  end

  it "is valid with attributes" do
    sales_invoice = Eol::AgingReceivablesList.new(invoice_ID: "abc-def")
    expect(sales_invoice.valid?).to eq(true)
  end

  context "Applying filters" do
    resource = Eol::AgingReceivablesList.new(id: '12abcdef-1234-1234-1234-123456abcdef')
    it "should apply ID filter for find" do
      expect(Eol).to receive(:get).with("read/financial/AgingReceivablesList(guid'12abcdef-1234-1234-1234-123456abcdef')?")
      resource.find
    end

    it "should apply no filters for find_all" do
      resource = Eol::AgingReceivablesList.new(type: 2)
      expect(Eol).to receive(:get).with("read/financial/AgingReceivablesList?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      resource = Eol::AgingReceivablesList.new(id: "12abcdef-1234-1234-1234-123456abcdef", type: "2")
      expect(Eol).to receive(:get).with("read/financial/AgingReceivablesList?$filter=Type+eq+'2'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:type, :id])
    end
  end
end

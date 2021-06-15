require 'spec_helper'

describe Eol::PrintedSalesInvoice do
  it "can initialize" do
    sales_invoice = Eol::PrintedSalesInvoice.new
    expect(sales_invoice).to be_a(Eol::PrintedSalesInvoice)
  end

  it "is in valid without attributes" do
    sales_invoice = Eol::PrintedSalesInvoice.new
    expect(sales_invoice.valid?).to eq(false)
  end

  it "is valid with attributes" do
    sales_invoice = Eol::PrintedSalesInvoice.new(invoice_ID: "abc-def")
    expect(sales_invoice.valid?).to eq(true)
  end

  context "Applying filters" do
    resource = Eol::PrintedSalesInvoice.new(id: 123)
    it "should apply ID filter for find" do
      expect(Eol).to receive(:get).with("salesinvoice/PrintedSalesInvoices(guid'123')?")
      resource.find
    end

    it "should apply no filters for find_all" do
      resource = Eol::PrintedSalesInvoice.new(type: 2)
      expect(Eol).to receive(:get).with("salesinvoice/PrintedSalesInvoices?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      resource = Eol::PrintedSalesInvoice.new(id: "12abcdef-1234-1234-1234-123456abcdef", type: "2")
      expect(Eol).to receive(:get).with("salesinvoice/PrintedSalesInvoices?$filter=Type+eq+'2'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:type, :id])
    end
  end
end

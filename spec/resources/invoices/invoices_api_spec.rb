require 'spec_helper'

describe Eol::SalesInvoice do
  it "can initialize" do
    sales_invoice = Eol::SalesInvoice.new
    expect(sales_invoice).to be_a(Eol::SalesInvoice)
  end

  it "is not valid without certain attributes" do
    sales_invoice = Eol::SalesInvoice.new
    expect(sales_invoice.valid?).to eq(false)
  end

  it "is valid with certain attributes" do
    sales_invoice = Eol::SalesInvoice.new(journal:"my-awesome-journal", ordered_by: "1230")
    expect(sales_invoice.valid?).to eq(true)
  end

  it "sanitezes the relationships" do
    journal = "another-awesome-journal"
    id = "232878"
    sales_invoice = Eol::SalesInvoice.new(journal: journal, ordered_by: Eol::Contact.new(first_name: "Karel", last_name: "Appel", id: id))
    expect(sales_invoice.sanitize).to eq({"OrderedBy" => id, "Journal" => "another-awesome-journal" })
  end

  context "Applying filters" do
    resource = Eol::SalesInvoice.new(id: "12abcdef-1234-1234-1234-123456abcdef", journal: "22")
    it "should apply ID filter for find" do
      expect(Eol).to receive(:get).with("salesinvoice/SalesInvoices(guid'12abcdef-1234-1234-1234-123456abcdef')?")
      resource.find
    end

    it "should apply no filters for find_all" do
      resource = Eol::SalesInvoice.new(id: "12abcdef-1234-1234-1234-123456abcdef", journal: "22")
      expect(Eol).to receive(:get).with("salesinvoice/SalesInvoices?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      resource = Eol::SalesInvoice.new(id: "12abcdef-1234-1234-1234-123456abcdef", journal: "22")
      expect(Eol).to receive(:get).with("salesinvoice/SalesInvoices?$filter=Journal+eq+'22'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:journal, :id])
    end

    it "should apply given filters for find_by as an array" do
      resource = Eol::SalesInvoice.new(id: "12abcdef-1234-1234-1234-123456abcdef", journal: ["22", "24"])
      expect(Eol).to receive(:get).with("salesinvoice/SalesInvoices?$filter=Journal+eq+'22'+or+Journal+eq+'24'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:journal, :id])
    end

    it 'should apply a numeric value without quotes' do
      resource = Eol::SalesInvoice.new(order_number: 15300007)
      expect(Eol).to receive(:get).with("salesinvoice/SalesInvoices?$filter=OrderNumber+eq+15300007")
      resource.find_by(filters: [:order_number])
    end
  end
end

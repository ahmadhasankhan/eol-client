require 'spec_helper'

describe Eol::Costunit do
  it "can initialize" do
    costunit = Eol::Costunit.new
    expect(costunit).to be_a(Eol::Costunit)
  end

  it "accepts attribute setter" do
    costunit = Eol::Costunit.new
    costunit.code = "78238"
    expect(costunit.code).to eq "78238"
  end

  it "returns value for getters" do
    costunit = Eol::Costunit.new({ "Code" => "345" })
    expect(costunit.code).to eq "345"
  end

  it "crashes and burns when getting an unset attribute" do
    costunit = Eol::Costunit.new({ name: "Piet" })
    expect(costunit.try(:code)).to eq nil
  end

  it "is valid with mandatory attributes" do
    costunit = Eol::Costunit.new(code: "23", description: "tralalala")
    expect(costunit.valid?).to eq(true)
  end

  it "is not valid without mandatory attributes" do
    costunit = Eol::Costunit.new
    expect(costunit.valid?).to eq(false)
  end

  let(:resource) { resource = Eol::Costunit.new(id: "12abcdef-1234-1234-1234-123456abcdef", code: "1223") }

  context "Applying filters" do
    it "should apply ID filter for find" do
      expect(Eol).to receive(:get).with("hrm/Costunits(guid'12abcdef-1234-1234-1234-123456abcdef')?")
      resource.find
    end

    it "should apply no filters for find_all" do
      expect(Eol).to receive(:get).with("hrm/Costunits?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      expect(Eol).to receive(:get).with("hrm/Costunits?$filter=Code+eq+'1223'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:code, :id])
    end
  end

  context "Applying order" do
    it "should apply the order_by and filters" do
      expect(Eol).to receive(:get).with("hrm/Costunits?$orderby=Code&$filter=Code+eq+'1223'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:code, :id], order_by: :code)
    end

    it "should only apply the order_by" do
      expect(Eol).to receive(:get).with("hrm/Costunits?$orderby=Code")
      resource.find_all(order_by: :code)
    end
  end

  context "Applying select" do
    it "should apply one select" do
      expect(Eol).to receive(:get).with("hrm/Costunits?$select=Code")
      resource.find_all(select: [:code])
    end

    it "should apply one select with find_by" do
      expect(Eol).to receive(:get).with("hrm/Costunits?$select=Code")
      resource.find_by(select: [:code])
    end

    it "should apply one select" do
      expect(Eol).to receive(:get).with("hrm/Costunits?$select=Code,Id")
      resource.find_all(select: [:code, :id])
    end
  end
end

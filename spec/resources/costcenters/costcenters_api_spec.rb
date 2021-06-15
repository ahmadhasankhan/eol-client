require 'spec_helper'

describe Eol::Costcenter do
  it "can initialize" do
    costcenter = Eol::Costcenter.new
    expect(costcenter).to be_a(Eol::Costcenter)
  end

  it "accepts attribute setter" do
    costcenter = Eol::Costcenter.new
    costcenter.code = "78238"
    expect(costcenter.code).to eq "78238"
  end

  it "returns value for getters" do
    costcenter = Eol::Costcenter.new({ "Code" => "345" })
    expect(costcenter.code).to eq "345"
  end

  it "crashes and burns when getting an unset attribute" do
    costcenter = Eol::Costcenter.new({ name: "Piet" })
    expect(costcenter.try(:code)).to eq nil
  end

  it "is valid with mandatory attributes" do
    costcenter = Eol::Costcenter.new(code: "23", description: "tralalala")
    expect(costcenter.valid?).to eq(true)
  end

  it "is not valid without mandatory attributes" do
    costcenter = Eol::Costcenter.new
    expect(costcenter.valid?).to eq(false)
  end

  let(:resource) { resource = Eol::Costcenter.new(id: "12abcdef-1234-1234-1234-123456abcdef", code: "1223") }

  context "Applying filters" do
    it "should apply ID filter for find" do
      expect(Eol).to receive(:get).with("hrm/Costcenters(guid'12abcdef-1234-1234-1234-123456abcdef')?")
      resource.find
    end

    it "should apply no filters for find_all" do
      expect(Eol).to receive(:get).with("hrm/Costcenters?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      expect(Eol).to receive(:get).with("hrm/Costcenters?$filter=Code+eq+'1223'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:code, :id])
    end
  end

  context "Applying order" do
    it "should apply the order_by and filters" do
      expect(Eol).to receive(:get).with("hrm/Costcenters?$orderby=Code&$filter=Code+eq+'1223'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:code, :id], order_by: :code)
    end

    it "should only apply the order_by" do
      expect(Eol).to receive(:get).with("hrm/Costcenters?$orderby=Code")
      resource.find_all(order_by: :code)
    end
  end

  context "Applying select" do
    it "should apply one select" do
      expect(Eol).to receive(:get).with("hrm/Costcenters?$select=Code")
      resource.find_all(select: [:code])
    end

    it "should apply one select with find_by" do
      expect(Eol).to receive(:get).with("hrm/Costcenters?$select=Code")
      resource.find_by(select: [:code])
    end

    it "should apply one select" do
      expect(Eol).to receive(:get).with("hrm/Costcenters?$select=Code,Id")
      resource.find_all(select: [:code, :id])
    end
  end
end

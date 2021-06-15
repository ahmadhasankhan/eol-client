require 'spec_helper'

describe Eol::Division do
  it "can initialize" do
    division = Eol::Division.new
    expect(division).to be_a(Eol::Division)
  end

  it "is valid without attributes" do
    division = Eol::Division.new
    expect(division.valid?).to eq(true)
  end

  it "is valid with attributes" do
    division = Eol::Division.new(description: "Example division")
    expect(division.valid?).to eq(true)
  end

  context "Applying filters" do
    resource = Eol::Division.new(id: 123)
    it "should apply ID filter for find" do
      expect(Eol).to receive(:get).with("system/Divisions(guid'123')?")
      resource.find
    end

    it "should apply no filters for find_all" do
      expect(Eol).to receive(:get).with("system/Divisions?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      resource = Eol::Division.new(id: "12abcdef-1234-1234-1234-123456abcdef")
      expect(Eol).to receive(:get).with("system/Divisions?$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:id])
    end
  end
end

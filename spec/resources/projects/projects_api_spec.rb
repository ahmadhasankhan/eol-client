require 'spec_helper'

describe Eol::Project do
  it "can initialize" do
    project = Eol::Project.new
    expect(project).to be_a(Eol::Project)
  end

  it "accepts attribute setter" do
    project = Eol::Project.new
    project.code = "P001"
    expect(project.code).to eq "P001"
  end

  it "returns value for getters" do
    project = Eol::Project.new({ "description" => "Urenbundel 30 uur" })
    expect(project.description).to eq "Urenbundel 30 uur"
  end

  it "crashes and burns when getting an unset attribute" do
    project = Eol::Project.new({ code: "P001" })
    expect(project.try(:code)).to eq nil
  end

  context "Applying filters" do
    it "should apply ID filter for find" do
      resource = Eol::Project.new(id: "12abcdef-1234-1234-1234-123456abcdef")
      expect(Eol).to receive(:get).with("project/Projects(guid'12abcdef-1234-1234-1234-123456abcdef')?")
      resource.find
    end

    it "should apply no filters for find_all" do
      resource = Eol::Project.new(id: "12abcdef-1234-1234-1234-123456abcdef", code: "P001")
      expect(Eol).to receive(:get).with("project/Projects?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      resource = Eol::Project.new(id: "12abcdef-1234-1234-1234-123456abcdef", code: "P001")
      expect(Eol).to receive(:get).with("project/Projects?$filter=Code+eq+'P001'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:code, :id])
    end
  end

  context "Applying order" do
    it "should apply the order_by and filters" do
      resource = Eol::Project.new(id: "12abcdef-1234-1234-1234-123456abcdef", code: "P001")
      expect(Eol).to receive(:get).with("project/Projects?$orderby=Code&$filter=Code+eq+'P001'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:code, :id], order_by: :code)
    end

    it "should only apply the order_by" do
      resource = Eol::Project.new(id: "12abcdef-1234-1234-1234-123456abcdef", code: "P001")
      expect(Eol).to receive(:get).with("project/Projects?$orderby=Code")
      resource.find_all(order_by: :code)
    end
  end

  context "Applying select" do
    it "should apply one select" do
      resource = Eol::Project.new(id: "12abcdef-1234-1234-1234-123456abcdef", code: "P001")
      expect(Eol).to receive(:get).with("project/Projects?$select=Code")
      resource.find_all(select: [:code])
    end

    it "should apply one select with find_by" do
      resource = Eol::Project.new(id: "12abcdef-1234-1234-1234-123456abcdef", code: "P001")
      expect(Eol).to receive(:get).with("project/Projects?$select=Code")
      resource.find_by(select: [:code])
    end

    it "should apply one select" do
      resource = Eol::Project.new(id: "12abcdef-1234-1234-1234-123456abcdef", code: "P001")
      expect(Eol).to receive(:get).with("project/Projects?$select=Code,Description")
      resource.find_all(select: [:code, :description])
    end
  end
end

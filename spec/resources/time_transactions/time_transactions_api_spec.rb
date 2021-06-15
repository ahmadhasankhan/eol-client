require 'spec_helper'

describe Eol::TimeTransaction do
  it "can initialize" do
    project = Eol::TimeTransaction.new
    expect(project).to be_a(Eol::TimeTransaction)
  end

  it "accepts attribute setter" do
    project = Eol::TimeTransaction.new
    project.item = "eb73942a-53c0-4ee9-bbb2-6d985814a1b1"
    expect(project.item).to eq "eb73942a-53c0-4ee9-bbb2-6d985814a1b1"
  end

  it "returns value for getters" do
    project = Eol::TimeTransaction.new({ "notes" => "Urenbundel 30 uur" })
    expect(project.notes).to eq "Urenbundel 30 uur"
  end

  it "crashes and burns when getting an unset attribute" do
    project = Eol::TimeTransaction.new({ item: "eb73942a-53c0-4ee9-bbb2-6d985814a1b1" })
    expect(project.try(:item)).to eq nil
  end

  context "Applying filters" do
    it "should apply ID filter for find" do
      resource = Eol::TimeTransaction.new(id: "12abcdef-1234-1234-1234-123456abcdef")
      expect(Eol).to receive(:get).with("project/TimeTransactions(guid'12abcdef-1234-1234-1234-123456abcdef')?")
      resource.find
    end

    it "should apply no filters for find_all" do
      resource = Eol::TimeTransaction.new(id: "12abcdef-1234-1234-1234-123456abcdef", item: "eb73942a-53c0-4ee9-bbb2-6d985814a1b1")
      expect(Eol).to receive(:get).with("project/TimeTransactions?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      resource = Eol::TimeTransaction.new(id: "12abcdef-1234-1234-1234-123456abcdef", item: "eb73942a-53c0-4ee9-bbb2-6d985814a1b1")
      expect(Eol).to receive(:get).with("project/TimeTransactions?$filter=Item+eq+guid'eb73942a-53c0-4ee9-bbb2-6d985814a1b1'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:item, :id])
    end
  end

  context "Applying order" do
    it "should apply the order_by and filters" do
      resource = Eol::TimeTransaction.new(id: "12abcdef-1234-1234-1234-123456abcdef", item: "eb73942a-53c0-4ee9-bbb2-6d985814a1b1")
      expect(Eol).to receive(:get).with("project/TimeTransactions?$orderby=Item&$filter=Item+eq+guid'eb73942a-53c0-4ee9-bbb2-6d985814a1b1'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:item, :id], order_by: :item)
    end

    it "should only apply the order_by" do
      resource = Eol::TimeTransaction.new(id: "12abcdef-1234-1234-1234-123456abcdef", item: "eb73942a-53c0-4ee9-bbb2-6d985814a1b1")
      expect(Eol).to receive(:get).with("project/TimeTransactions?$orderby=Item")
      resource.find_all(order_by: :item)
    end
  end

  context "Applying select" do
    it "should apply one select" do
      resource = Eol::TimeTransaction.new(id: "12abcdef-1234-1234-1234-123456abcdef", item: "eb73942a-53c0-4ee9-bbb2-6d985814a1b1")
      expect(Eol).to receive(:get).with("project/TimeTransactions?$select=Item")
      resource.find_all(select: [:item])
    end

    it "should apply one select with find_by" do
      resource = Eol::TimeTransaction.new(id: "12abcdef-1234-1234-1234-123456abcdef", item: "eb73942a-53c0-4ee9-bbb2-6d985814a1b1")
      expect(Eol).to receive(:get).with("project/TimeTransactions?$select=Item")
      resource.find_by(select: [:item])
    end

    it "should apply one select" do
      resource = Eol::TimeTransaction.new(id: "12abcdef-1234-1234-1234-123456abcdef", item: "eb73942a-53c0-4ee9-bbb2-6d985814a1b1")
      expect(Eol).to receive(:get).with("project/TimeTransactions?$select=Item,Notes")
      resource.find_all(select: [:item, :notes])
    end
  end
end

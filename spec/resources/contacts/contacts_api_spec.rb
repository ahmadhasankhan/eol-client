require 'spec_helper'

describe Eol::Contact do
  it "can initialize" do
    contact = Eol::Contact.new
    expect(contact).to be_a(Eol::Contact)
  end

  it "accepts attribute setter" do
    contact = Eol::Contact.new
    contact.first_name = "Karel"
    expect(contact.first_name).to eq "Karel"
  end

  it "returns value for getters" do
    contact = Eol::Contact.new({ "BirthName" => "Karel" })
    expect(contact.birth_name).to eq "Karel"
  end

  it "crashes and burns when getting an unset attribute" do
    contact = Eol::Contact.new({ name: "Piet" })
    expect(contact.try(:birth_name)).to eq nil
  end

  context "Applying filters" do
    it "should apply ID filter for find" do
      resource = Eol::Contact.new(id: "12abcdef-1234-1234-1234-123456abcdef")
      expect(Eol).to receive(:get).with("crm/Contacts(guid'12abcdef-1234-1234-1234-123456abcdef')?")
      resource.find
    end

    it "should apply no filters for find_all" do
      resource = Eol::Contact.new(id: "12abcdef-1234-1234-1234-123456abcdef", name: "Karel")
      expect(Eol).to receive(:get).with("crm/Contacts?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      resource = Eol::Contact.new(id: "12abcdef-1234-1234-1234-123456abcdef", name: "Karel")
      expect(Eol).to receive(:get).with("crm/Contacts?$filter=Name+eq+'Karel'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:name, :id])
    end
  end

  context "Applying order" do
    it "should apply the order_by and filters" do
      resource = Eol::Contact.new(id: "12abcdef-1234-1234-1234-123456abcdef", name: "Karel")
      expect(Eol).to receive(:get).with("crm/Contacts?$orderby=Name&$filter=Name+eq+'Karel'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:name, :id], order_by: :name)
    end

    it "should only apply the order_by" do
      resource = Eol::Contact.new(id: "12abcdef-1234-1234-1234-123456abcdef", name: "Karel")
      expect(Eol).to receive(:get).with("crm/Contacts?$orderby=Name")
      resource.find_all(order_by: :name)
    end
  end

  context "Applying select" do
    it "should apply one select" do
      resource = Eol::Contact.new(id: "12abcdef-1234-1234-1234-123456abcdef", name: "Karel")
      expect(Eol).to receive(:get).with("crm/Contacts?$select=Name")
      resource.find_all(select: [:name])
    end

    it "should apply one select with find_by" do
      resource = Eol::Contact.new(id: "12abcdef-1234-1234-1234-123456abcdef", name: "Karel")
      expect(Eol).to receive(:get).with("crm/Contacts?$select=Name")
      resource.find_by(select: [:name])
    end

    it "should apply one select" do
      resource = Eol::Contact.new(id: "12abcdef-1234-1234-1234-123456abcdef", name: "Karel")
      expect(Eol).to receive(:get).with("crm/Contacts?$select=Name,Age")
      resource.find_all(select: [:name, :age])
    end
  end
end

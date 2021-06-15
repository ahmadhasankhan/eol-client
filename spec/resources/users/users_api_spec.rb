require 'spec_helper'

describe Eol::User do
  it "can initialize" do
    user = Eol::User.new
    expect(user).to be_a(Eol::User)
  end

  it "is valid without attributes" do
    user = Eol::User.new
    expect(user.valid?).to eq(true)
  end

  it "is valid with attributes" do
    user = Eol::User.new(email: "info@example.com")
    expect(user.valid?).to eq(true)
  end

  context "Applying filters" do
    resource = Eol::User.new(id: 123, email: "info@example.com")

    it "should apply no filters for find_all" do
      expect(Eol).to receive(:get).with("users/Users?")
      resource.find_all
    end

    it "should apply ID filter for find" do
      expect(Eol).to receive(:get).with("users/Users(guid'123')?")
      resource.find
    end

    it "should apply given filters for find_by" do
      expect(Eol).to receive(:get).with("users/Users?$filter=Email+eq+'info@example.com'")
      resource.find_by(filters: [:email])
    end
  end
end

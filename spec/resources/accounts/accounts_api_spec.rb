require 'spec_helper'

describe Eol::Account do
  it "can initialize" do
    account = Eol::Account.new
    expect(account).to be_a(Eol::Account)
  end

  it "accepts attribute setter" do
    account = Eol::Account.new
    account.website = "website"
    expect(account.website).to eq "website"
  end

  it "returns value for getters" do
    account = Eol::Account.new({ "Website" => "www.google.com" })
    expect(account.website).to eq "www.google.com"
  end

  it "crashes and burns when getting an unset attribute" do
    account = Eol::Account.new({ name: "Piet" })
    expect(account.try(:birth_name)).to eq nil
  end

  it "does not allow to set an invalid attribute" do
    account = Eol::Account.new
    account.airplane = "Boeing 777"
    expect(account.airplaine).to eq nil
  end
end

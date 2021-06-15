require 'spec_helper'

describe Eol::Mailbox do
  it "can initialize" do
    mailbox = Eol::Mailbox.new
    expect(mailbox).to be_a(Eol::Mailbox)
  end

  it "accepts attribute setter" do
    mailbox = Eol::Mailbox.new
    mailbox.account = "78238"
    expect(mailbox.account).to eq "78238"
  end

  it "returns value for getters" do
    mailbox = Eol::Mailbox.new({ "Account" => "345" })
    expect(mailbox.account).to eq "345"
  end

  it "crashes and burns when getting an unset attribute" do
    mailbox = Eol::Mailbox.new({ mailbox: "Karel@APPEL.COM" })
    expect(mailbox.try(:account)).to eq nil
  end

  it "is not valid without attributes" do
    mailbox = Eol::Mailbox.new
    expect(mailbox.valid?).to eq(false)
  end

  it "is valid with mailbox attribute" do
    mailbox = Eol::Mailbox.new(mailbox: "Marthyn@Live.nl")
    expect(mailbox.valid?).to eq(true)
  end

  let(:resource) { resource = Eol::Mailbox.new(id: "12abcdef-1234-1234-1234-123456abcdef", account: "1223") }

  context "Applying filters" do
    it "should apply ID filter for find" do
      expect(Eol).to receive(:get).with("mailbox/Mailboxes(guid'12abcdef-1234-1234-1234-123456abcdef')?")
      resource.find
    end

    it "should apply no filters for find_all" do
      expect(Eol).to receive(:get).with("mailbox/Mailboxes?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      expect(Eol).to receive(:get).with("mailbox/Mailboxes?$filter=Account+eq+'1223'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:account, :id])
    end
  end

  context "Applying order" do
    it "should apply the order_by and filters" do
      expect(Eol).to receive(:get).with("mailbox/Mailboxes?$orderby=Account&$filter=Account+eq+'1223'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:account, :id], order_by: :account)
    end

    it "should only apply the order_by" do
      expect(Eol).to receive(:get).with("mailbox/Mailboxes?$orderby=Account")
      resource.find_all(order_by: :account)
    end
  end

  context "Applying select" do
    it "should apply one select" do
      expect(Eol).to receive(:get).with("mailbox/Mailboxes?$select=Account")
      resource.find_all(select: [:account])
    end

    it "should apply one select with find_by" do
      expect(Eol).to receive(:get).with("mailbox/Mailboxes?$select=Account")
      resource.find_by(select: [:account])
    end

    it "should apply one select" do
      expect(Eol).to receive(:get).with("mailbox/Mailboxes?$select=Account,Id")
      resource.find_all(select: [:account, :id])
    end
  end
end

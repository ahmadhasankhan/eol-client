require 'spec_helper'

describe Eol do
  it 'has a version number' do
    expect(Eol::Version).not_to be nil
  end

  describe ".client" do
    it "should be an Eol client" do
      expect(Eol.client).to be_a Eol::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      expect(Eol.adapter).to eq Eol::Config::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Eol.adapter = :typhoeus
      expect(Eol.adapter).to eq :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      expect(Eol.endpoint).to eq Eol::Config::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      Eol.endpoint = 'http://other_api.com'
      expect(Eol.endpoint).to eq 'http://other_api.com'
    end
  end

  describe ".format" do
    it "should return the default format" do
      expect(Eol.response_format).to eq Eol::Config::DEFAULT_FORMAT
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      expect(Eol.user_agent).to eq Eol::Config::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Eol.user_agent = 'Custom User Agent'
      expect(Eol.user_agent).to eq 'Custom User Agent'
    end
  end

  describe ".configure" do

    Eol::Config::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        Eol.configure do |config|
          config.send("#{key}=", key)
          expect(Eol.send(key)).to eq key
        end
      end
    end
  end
end

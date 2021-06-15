require "spec_helper"

describe Eol do
  it "has a config" do
    expect(Eol.config[:base_url]).to eq("https://start.exactonline.nl")
  end

  let(:new_url) { "www.google.com/api" }

  it "can set a config var" do
    Eol.configure do |config|
      config.base_url = new_url
    end

    expect(Eol.config[:base_url]).to eq(new_url)
  end

  it "should be thread safe" do
    Eol.configure { |config| config.base_url = 'foo' }

    Thread.new do
      Eol.configure { |config| config.base_url = 'bar' }
    end.join

    expect(Eol.config[:base_url]).to eq 'foo'
  end

  it "should default to main thread values" do
    Eol.configure { |config| config.base_url = 'foo' }

    Thread.new do
      expect(Eol.config[:base_url]).to eq 'foo'
    end.join
  end

  it "should configure a default logger when included" do
    expect(Eol.logger).to eq(Eol::Config::DEFAULT_LOGGER)
  end

  it "should configure a given logger when specified" do
    expect(Eol.logger).to eq(Eol::Config::DEFAULT_LOGGER)
    obj = ::Object.new
    Eol.configure { |config| config.logger = obj }
    expect(Eol.logger).to eq(obj)
  end

  it "should reset logger configuration to default" do
    expect(Eol.logger).to eq(Eol::Config::DEFAULT_LOGGER)
    obj = ::Object.new
    Eol.configure { |config| config.logger = obj }
    expect(Eol.logger).to eq(obj)
    Eol.reset
    expect(Eol.logger).to eq(Eol::Config::DEFAULT_LOGGER)
  end
end

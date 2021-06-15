require 'spec_helper'

describe Eol::Utils do
  it "camelizes a string" do
    expect(Eol::Utils.camelize("a_class_boom")).to eq "AClassBoom"
  end

  it "camelizes a string with first letter downcase" do
    expect(Eol::Utils.camelize("a_class_boom", false)).to eq "aClassBoom"
  end

  it "demodulizes a class name in a module" do
    expect(Eol::Utils.demodulize("Module::Class")).to eq "Class"
  end

  it "pluralizes a word" do
    expect(Eol::Utils.pluralize("Book")).to eq "Books"
  end

  it "doesn't double pluralize books to bookss" do
    expect(Eol::Utils.pluralize("Books")).to eq "Books"
  end

  it "shows a collection path of a class name" do
    expect(Eol::Utils.collection_path("Exact::User")).to eq "users"
  end

  let(:original_hash) do
    {
      "Module::Foo" => "bar",
      "module::class" => "bar",
      "ModuleOne::ClassTwo" => "bar"
    }
  end

  let(:normalized_hash) do
    {
      :"module/foo" => "bar",
      :"module/class" => "bar",
      :"module_one/class_two" => "bar"
    }
  end

  it "normalizes a hash" do
    expect(Eol::Utils.normalize_hash(original_hash)).to eq(normalized_hash)
  end
end

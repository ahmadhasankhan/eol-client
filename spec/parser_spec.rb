require 'spec_helper'

describe Eol::Parser do
  let(:sample_json) {
    {
      "d" => {
        "results" => [
          {
            "__metadata" => {
              "uri" => "https://start.exactonline.nl/api/v1/current/Me(guid'29dee5ea-9132-474c-b188-e8364ecebadd')",
              "type" => "Exact.Web.Api.System.Me"
            },
            "CurrentDivision" => 797636,
            "FullName" => "Marthyn Olthof",
            "UserID" => "29dee5ea-9132-474c-b188-e8364ecebadd",
            "UserName" => "MarthynOlthof",
            "LanguageCode" => "nl-NL",
            "Legislation" => "1",
            "Email" => "marthynolthof@hoppinger.com",
            "Title" => "DHR",
            "FirstName" => "Marthyn",
            "LastName" => "Olthof",
            "Gender" => "O",
            "Language" => "NL",
            "Phone" => "0647195564"
          },
          {
            "__metadata" => {
              "uri" => "https://start.exactonline.nl/api/v1/current/Me(guid'29dee5ea-2331-474c-b188-e8364ecebadd')",
              "type" => "Exact.Web.Api.System.Me"
            },
            "CurrentDivision" => 797636,
            "FullName" => "Karel Appel",
            "UserID" => "29dee5ea-2331-474c-b188-e8364ecebadd",
            "UserName" => "KarelAppel",
            "LanguageCode" => "nl-NL",
            "Legislation" => "1",
            "Email" => "karelappel@hoppinger.com",
            "Title" => "DHR",
            "FirstName" => "Karel",
            "LastName" => "Appel",
            "Gender" => "M",
            "Language" => "NL",
            "Phone" => "0595424454"
          }
        ]
      }
    }.to_json
  }

  it "parses and returns all results" do
    expect(Eol::Parser.new(sample_json).results.length).to eq(2)
  end

  it "parses and returns the first result" do
    expect(Eol::Parser.new(sample_json).first_result["FullName"]).to eq("Marthyn Olthof")
    expect(Eol::Parser.new(sample_json).first_result["FullName"]).to_not eq("Karel Appel")
  end
end

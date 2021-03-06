require 'spec_helper'

describe Eol::Response do
  let(:sample_json) {
    {
      "d" => {
        "results" => [
          {
            "__metadata" => {
              "uri" => "https://start.exactonline.nl/api/v1/current/Me(guid'29dee5ea-9132-474c-b188-e8364ecebadd')",
              "type" => "Exact.Web.Api.System.Contact"
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
          }
        ]
      }
    }.to_json
  }

  let(:error_json) {
    "{\r\n\"error\": {\r\n\"code\": \"\", \"message\": {\r\n\"lang\": \"\", \"value\": \"Unrecognized 'Edm.Guid' literal 'guid'dsadsds'' in '6'.\"\r\n}\r\n}\r\n}"
  }

  let(:unknown_class_json) {
    {
      "d" => {
        "results" => [
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

  let(:good_response) {
    Faraday::Response.new(body: sample_json, status: 200)
  }

  let(:unkown_class_response) {
    Faraday::Response.new(body: unknown_class_json, status: 200)
  }

  let(:not_found_response) {
    Faraday::Response.new(status: 404)
  }

  let(:random_fail_response) {
    Faraday::Response.new(status: Eol::Response::ERROR_CODES.sample, body: error_json)
  }

  let(:random_unauthorized_response) {
    Faraday::Response.new(status: Eol::Response::UNAUTHORIZED_CODES.sample, body: error_json)
  }

  let(:random_success_response) {
    Faraday::Response.new(status: Eol::Response::SUCCESS_CODES.sample)
  }

  it "returns true for success" do
    expect(Eol::Response.new(random_success_response).success?).to eq(true)
  end

  it "returns true for unauthorized" do
    expect { Eol::Response.new(random_unauthorized_response) }.to raise_exception(Eol::BadRequestException)
  end

  it "resolves the type for a request properly" do
    expect(Eol::Response.new(good_response).results.first.class).to eq(Eol::Contact)
  end

  it "resolves the error for a failed request properly" do
    expect { Eol::Response.new(random_fail_response) }.to raise_exception(Eol::BadRequestException)
  end

  it "resolves the unknown class for a request properly" do
    expect(Eol::Response.new(unkown_class_response).results.first.full_name).to eq("Karel Appel")
  end

  it "returns the first result" do
    expect(Eol::Response.new(good_response).results.first).to be_a(Eol::Contact)
  end
end

# frozen_string_literal: true

require "mechanize"
require "uri"
require "json"

require File.expand_path("../utils", __FILE__)
require File.expand_path("../response", __FILE__)

# from https://developers.exactonline.com/#Example retrieve access token.html

# This whole class is going to be replaced due to Exact Online's new policies.
# https://support.exactonline.com/community/s/knowledge-base#All-All-HNO-Concept-general-security-gen-auth-totpc

module Eol
  # rubocop:disable Metrics/ModuleLength
  module OAuth
    def authorized?
      # Do a test call, return false if 401 or any error code
      response = Eol.get("/Current/Me", no_division: true)
      response.results.first.present?
    rescue BadRequestException
      Eol.error "Not yet authorized"
      return false
    end

    def authorize_division
      get("/Current/Me", no_division: true).results.first.current_division
    end

    # Return URL for OAuth authorization
    def authorize_url(options = {})
      options[:response_type] ||= "code"
      options[:redirect_uri] ||= redirect_uri
      params = authorization_params.merge(options)
      uri = URI("#{base_url}/api/oauth2/auth/")
      uri.query = URI.encode_www_form(params)
      uri.to_s
    end

    # Return an access token from authorization
    def get_access_token(code, _options = {})
      conn = Faraday.new(url: base_url) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
      params = access_token_params(code)
      conn.post do |req|
        req.url "/api/oauth2/token"
        req.body = params
        req.headers["Accept"] = "application/json"
      end
    end

    # Return an access token from authorization via refresh token
    def get_refresh_token(refresh_token)
      conn = Faraday.new(url: config[:base_url]) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end

      params = refresh_access_token_params(refresh_token)

      conn.post do |req|
        req.url "/api/oauth2/token"
        req.body = params
        req.headers["Accept"] = "application/json"
        req.headers["Content-Type"] = "application/x-www-form-urlencoded"
      end
    end

    private

    def authorization_params
      {
        client_id: client_id
      }
    end

    def access_token_params(code)
      {
        client_id: client_id,
        client_secret: client_secret,
        grant_type: "authorization_code",
        code: code,
        redirect_uri: redirect_uri
      }
    end

    def refresh_access_token_params(code)
      {
        client_id: client_id,
        client_secret: client_secret,
        grant_type: "refresh_token",
        refresh_token: code
      }
    end
  end

  class OauthResponse < Response
    def body
      JSON.parse(@response.body)
    end

    def access_token
      body["access_token"]
    end

    def division
      body["division"]
    end

    def refresh_token
      body["refresh_token"]
    end
  end
end
# frozen_string_literal: true

require 'json'
require 'net/http'

module Rails
  module Vault
    module JWT
      class KeyProvider
        def initialize(cache = nil)
          @cache = cache || Rails::Vault::JWT.config.cache
        end

        def keys(issuer)
          if @cache.respond_to?(:fetch)
            @cache.fetch("keys/#{issuer}", expires_in: 5.minutes) do
              fetch_keys issuer
            end
          else
            fetch_keys issuer
          end
        end

        def fetch_keys(issuer)
          raw = Net::HTTP.get URI.parse("#{issuer}/.well-known/keys")
          JSON.parse raw, symbolize_names: true
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'active_support/core_ext/hash/indifferent_access'
require 'base64'
require 'jwt'

module Rails
  module Vault
    module JWT
      module Decoder
        class << self
          def decode(token)
            HashWithIndifferentAccess.new(::JWT.decode(
              token,
              nil,
              true,
              {
                algorithms: ['RS256', 'RS512'],
                jwks: key_provider.keys(issuer(token))
              }
            )[0])
          rescue StandardError
            nil
          end

          def issuer(token)
            parts = token.split('.')
            body = HashWithIndifferentAccess.new(JSON.parse(Base64.decode64(parts[1])))
            body[:iss]
          end

          def key_provider
            @key_provider ||= KeyProvider.new
          end
        end
      end
    end
  end
end

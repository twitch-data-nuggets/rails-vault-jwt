# frozen_string_literal: true

require 'vault'

module Rails
  module Vault
    module JWT
      module TokenProvider
        class BaseProvider
          attr_reader :expire_time

          def initialize(*_args, bearer_role_name: nil, **_kwargs)
            @expire_time = DateTime.now
            @bearer_role_name = bearer_role_name || ENV.fetch('VAULT_BEARER_ROLE', '')
          end

          def auth; end

          def bearer_token
            token
            client.logical.read("identity/oidc/token/#{@bearer_role_name}")&.data[:token]
          end

          def token
            unless token_valid?
              auth_data = auth
              @token = auth_data.client_token
              @expire_time = DateTime.now + (auth_data.lease_duration / 86_400.0)
              client.token = @token
            end

            @token
          end

          def token_expired?
            DateTime.now > @expire_time
          end

          def token_life_remaining
            (@expire_time - DateTime.now) * 86_400.0
          end

          def token_valid?
            !@token.nil? && !token_expired?
          end

          def client
            @client ||= ::Vault::Client.new
          end
        end
      end
    end
  end
end

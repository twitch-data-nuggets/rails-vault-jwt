# frozen_string_literal: true

module Rails
  module Vault
    module JWT
      module TokenProvider
        class RoleID < BaseProvider
          def initialize(*args, mount_name: 'approle', role_id: nil, secret_id: nil, token_ttl: '5m')
            super
            @mount_name = mount_name
            @role_id = role_id || ENV.fetch('ROLE_ID')
            @secret_id = secret_id || ENV.fetch('SECRET_ID')
            @token_ttl = token_ttl
          end

          def auth
            client.logical.write("auth/#{@mount_name}/login", role_id: @role_id, secret_id: @secret_id,
                                                              ttl: @token_ttl)&.auth
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'rails/vault/jwt/concerns/auth_required'
require 'rails/vault/jwt/config'
require 'rails/vault/jwt/decoder'
require 'rails/vault/jwt/key_provider'
require 'rails/vault/jwt/token_provider/base_provider'
require 'rails/vault/jwt/token_provider/role_id'
require 'rails/vault/jwt/version'

module Rails
  module Vault
    module JWT
      class Error < StandardError; end

      class << self
        def configure
          @config = Config.new
          yield(@config) if block_given?
          @config
        end

        def config
          @config || configure
        end
      end
    end
  end
end

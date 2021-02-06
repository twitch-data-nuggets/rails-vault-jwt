# frozen_string_literal: true

require 'forwardable'

module Rails
  module Vault
    module JWT
      class Config
        extend Forwardable
        attr_accessor :cache, :logger, :valid_issuers
        attr_reader :token_provider

        def initialize
          @logger = defined?(Rails) && defined?(Rails.logger) ? Rails.logger : Logger.new($stdout)
          @valid_issuers = []
        end

        def token_provider=(value)
          @token_provider = if value.is_a? Class
                              value.new
                            else
                              value
                            end
        end

        def_delegators :@token_provider, :token, :bearer_token
      end
    end
  end
end

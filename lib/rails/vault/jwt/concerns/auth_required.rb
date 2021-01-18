# frozen_string_literal: true

require 'active_support'

module Rails
  module Vault
    module JWT
      module Concerns
        module AuthRequired
          extend ActiveSupport::Concern

          included do
            before_action :authenticate_request!
          end

          protected

          def authenticate_request!
            unless token_valid?
              render json: { errors: ['Not Authenticated'] }, status: :unauthorized
              nil
            end
          rescue ::JWT::VerificationError, ::JWT::DecodeError
            render json: { errors: ['Not Authenticated'] }, status: :unauthorized
          end

          private

          def http_token
            @http_token ||= (request.headers['Authorization'].split.last if request.headers['Authorization'].present?)
          end

          def auth_token
            @auth_token ||= JWT::Decoder.decode(http_token)
          end

          def token_valid?
            http_token && auth_token && !token_expired?
          end

          def token_expired?
            exp = auth_token[:exp].to_i
            DateTime.now.to_time.to_i > exp
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'securerandom'

RSpec.describe Rails::Vault::JWT::TokenProvider::RoleID do
  let(:role_id) { SecureRandom.uuid }
  let(:secret_id) { SecureRandom.uuid }
  let(:token_ttl) { 300 / 86_400.0 }
  let(:token_expire_time) { DateTime.now + token_ttl }

  subject { described_class.new role_id: role_id, secret_id: secret_id }

  describe '#auth' do
    let(:token) { 'abc123' }
    let(:secret) do
      ::Vault::Secret.new({
        auth: secret_auth
      })
    end
    let(:secret_auth) do
      {
        client_token: token,
        lease_duration: 1800
      }
    end

    it 'authenticates against the approle mount' do
      allow(subject.client.logical).to receive(:write).and_return(secret)
      expect(subject.auth).to be_a ::Vault::SecretAuth
    end
  end
end

# frozen_string_literal: true

RSpec.describe Rails::Vault::JWT::TokenProvider::BaseProvider do
  let(:token_ttl) { 300 / 86_400.0 }
  let(:token_expire_time) { DateTime.now + token_ttl }

  describe '#auth' do
    it { expect(subject.auth).to be_nil }
  end

  describe '#bearer_token' do
    let(:token) { 'abc123' }
    let(:secret) do
      ::Vault::Secret.new({
                            data: secret_data
                          })
    end
    let(:secret_data) do
      {
        client_id: SecureRandom.uuid,
        token: 'abc.123.foo',
        ttl: 300
      }
    end

    it 'fetches a bearer token' do
      allow(subject).to receive(:token)
      allow(subject.client.logical).to receive(:read).and_return(secret)
      expect(subject.bearer_token).to be_a String
    end
  end

  describe '#token' do
    let(:token) { 'abc123' }
    let(:vault_auth) do
      ::Vault::SecretAuth.new(
        client_token: token,
        lease_duration: 1800
      )
    end

    it 'fetches a new token' do
      allow(subject).to receive(:auth).and_return(vault_auth)
      expect(subject.token).to eq token
      expect(subject.token_valid?).to be_truthy
    end
  end

  describe '#token_expired?' do
    it 'returns true after initialization' do
      expect(subject.token_expired?).to be_truthy
    end

    it 'returns false after fetching token' do
      subject.instance_variable_set('@expire_time', token_expire_time)
      expect(subject.token_expired?).to be_falsey
    end
  end

  describe '#token_life_remaining' do
    it 'returns a negative number' do
      subject.instance_variable_set('@expire_time', DateTime.now - token_ttl)
      expect(subject.token_life_remaining).to be_within(0.1).of(-300)
    end

    it 'returns a positive number' do
      subject.instance_variable_set('@expire_time', token_expire_time)
      expect(subject.token_life_remaining).to be_within(0.1).of(300)
    end
  end

  describe '#token_valid?' do
    it 'is false after initialization' do
      expect(subject.token_valid?).to be_falsey
    end

    it 'is true' do
      subject.instance_variable_set('@expire_time', token_expire_time)
      subject.instance_variable_set('@token', {})
      expect(subject.token_valid?).to be_truthy
    end
  end

  describe '#client' do
    it 'returns a Vault client' do
      expect(subject.client).to be_a ::Vault::Client
    end
  end
end

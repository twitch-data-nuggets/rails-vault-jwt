# frozen_string_literal: true

require 'active_support'
require 'support/shared_context/jwt_context'

RSpec.describe Rails::Vault::JWT::Decoder do
  include_context 'jwt'

  describe '#decode' do
    it 'returns a hash of the token' do
      allow(subject.key_provider).to receive(:keys).and_return(keys)
      r = subject.decode token
      expect(r).to be_a Hash
      expect(subject.key_provider).to have_received(:keys).with('http://localhost')
    end

    it 'returns nil' do
      allow(subject.key_provider).to receive(:keys).and_return(keys)
      r = subject.decode bad_token
      expect(r).to be_nil
    end
  end

  describe '#issuer' do
    it 'returns http://localhost' do
      expect(subject.issuer(token)).to eq 'http://localhost'
    end
  end
end

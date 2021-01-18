# frozen_string_literal: true

require 'action_controller'
require 'support/shared_context/jwt_context'

class DummyController < ActionController::Base; end

RSpec.describe Rails::Vault::JWT::Concerns::AuthRequired, type: :controller do
  include_context 'jwt'

  subject do
    c = DummyController.new
    c.extend(described_class)
    c
  end

  describe '#authenticate_request!' do
    it 'succeeds' do
      allow(subject).to receive(:token_valid?).and_return(true)
      expect(subject.send(:authenticate_request!)).to be_nil
    end

    it 'returns an unauthorized status' do
      allow(subject).to receive(:token_valid?).and_return(false)
      allow(subject).to receive(:render)
      expect(subject.send(:authenticate_request!)).to be_nil
      expect(subject).to have_received(:render).with(hash_including(status: :unauthorized))
    end
  end

  describe '#auth_token' do
    it 'returns a verified token' do
      allow(subject).to receive(:http_token).and_return(token)
      allow(Rails::Vault::JWT::Decoder).to receive(:decode).and_return(decoded_token)
      expect(subject.send(:auth_token)).to be_a Hash
    end

    it 'returns nil' do
      allow(subject).to receive(:http_token).and_return(bad_token)
      expect(subject.send(:auth_token)).to be_nil
    end
  end

  describe '#http_token' do
    let(:headers) do
      HashWithIndifferentAccess.new {}
    end

    let(:headers_with_auth) do
      headers.update({ Authorization: "Bearer #{token}" })
    end

    it 'returns the token' do
      allow(subject.request).to receive(:headers).and_return(headers_with_auth)
      expect(subject.send(:http_token)).to eq token
    end

    it 'returns nil' do
      allow(subject.request).to receive(:headers).and_return(headers)
      expect(subject.send(:http_token)).to be_nil
    end
  end

  describe '#token_expired?' do
    let(:invalid_time) { DateTime.parse '2274-07-12T19:11:42Z' }
    it 'returns true' do
      allow(subject).to receive(:auth_token).and_return(decoded_token)
      allow(DateTime).to receive(:now).and_return(invalid_time)
      expect(subject.send(:token_expired?)).to be_truthy
    end

    it 'returns false' do
      allow(subject).to receive(:auth_token).and_return(decoded_token)
      expect(subject.send(:token_expired?)).to be_falsey
    end
  end

  describe '#token_valid?' do
    it 'returns true' do
      allow(subject).to receive(:http_token).and_return(token)
      allow(subject).to receive(:auth_token).and_return(decoded_token)
      expect(subject.send(:token_valid?)).to be_truthy
    end
  end
end

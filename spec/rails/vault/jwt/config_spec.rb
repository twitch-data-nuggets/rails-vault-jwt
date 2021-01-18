# frozen_string_literal: true

RSpec.describe Rails::Vault::JWT::Config do
  describe '#token_provider' do
    let(:provider_class) { Rails::Vault::JWT::TokenProvider::BaseProvider }

    describe 'with provider class' do
      it 'creates an instance of the class' do
        subject.token_provider = provider_class
        expect(subject.token_provider).not_to be_a Class
        expect(subject.token_provider).to be_a provider_class
      end
    end

    describe 'with provider object' do
      let(:provider) { provider_class.new }

      it 'stores the object as-is' do
        subject.token_provider = provider
        expect(subject.token_provider).to be provider
      end
    end
  end
end

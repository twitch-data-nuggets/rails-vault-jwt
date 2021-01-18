# frozen_string_literal: true

RSpec.describe Rails::Vault::JWT do
  it 'has a version number' do
    expect(Rails::Vault::JWT::VERSION).not_to be nil
  end
end

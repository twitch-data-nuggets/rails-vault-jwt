# frozen_string_literal: true

require 'active_support'

RSpec.describe Rails::Vault::JWT::KeyProvider do
  let(:issuer) { 'http://localhost' }

  describe '#fetch_keys' do
    let(:jwks) do
      '{"keys":[{"use":"sig","kty":"RSA","kid":"07249fb8-ec8a-2b85-f1aa-51c2ce6097c0","alg":"RS256","n":"mzgIALhj_iqTZqqOepMIginGdW1oNJwr2TD3avL9NXD6LUTiKSOrE6qWrDCfzGkoEUJqMhD805pOYeC7tQLXBTxOY5SC9tdNsGafVGC06VxhF48JOZGmknb9ERWIcf060I8oiXxsV_FjfQlnmYk5afeZhRt_dGUdNhjgrldFjqqtOVKybYdD1G77GzDXSTqcLsUmbgblRwus4zoVpV-Gdgk00jaWV5ZSMPzN-Z-w_xo1yHdmt_3PZpfldfk24AEWcEOgF4C_KzWlHU_RrUD_p07vAO9tO2fFsylaAICWoJNmBngCzA0ixKlUhYV-Z6PPnE_iCBOieVP4iIcKTEHRKQ","e":"AQAB"},{"use":"sig","kty":"RSA","kid":"859c9e07-d416-82c8-2e03-3f047932598a","alg":"RS256","n":"yfjKV4eZ9US3MxjaIi-Zi6y_3dL1J_EsqSJ2DN11PcYWnRentjMfNZt28_0HnEwKrlOx3R01JgK38yUFpWJ-T_w7bKNbo3Z3XDi-5iknDcNJqL2g8lgkymRjHvpuchAUNqTZIzYxSqpR4fgGKUJUdrGuV6Vwom6ujB8pJiATOT-yuTR7sBm_Mi1XNDsAHuVoaZK4xYPfgqeUVNU1Ds0VmzJTh77SXgf6omfSKT-XNlPlFkQEz7J1Ht2hgPB-ipQwTAadqWPyMWnUG2Deceh0UG1fEyPpwQQG1UCH1yim4uoUNi8yXrM0XWgvAz3-60BYTn2wCQ43IX4fUvluaD8lFw","e":"AQAB"}]}'
    end

    it 'returns a JWKS' do
      allow(Net::HTTP).to receive(:get).and_return(jwks)
      keys = subject.fetch_keys issuer
      expect(keys).to be_a Hash
      expect(keys[:keys]).to be_a Array
    end
  end

  describe '#keys' do
    let(:jwks) do
      {
        keys: [
          {
            use: 'sig',
            kty: 'RSA',
            kid: '07249fb8-ec8a-2b85-f1aa-51c2ce6097c0',
            alg: 'RS256',
            n: 'mzgIALhj_iqTZqqOepMIginGdW1oNJwr2TD3avL9NXD6LUTiKSOrE6qWrDCfzGkoEUJqMhD805pOYeC7tQLXBTxOY5SC9tdNsGafVGC06VxhF48JOZGmknb9ERWIcf060I8oiXxsV_FjfQlnmYk5afeZhRt_dGUdNhjgrldFjqqtOVKybYdD1G77GzDXSTqcLsUmbgblRwus4zoVpV-Gdgk00jaWV5ZSMPzN-Z-w_xo1yHdmt_3PZpfldfk24AEWcEOgF4C_KzWlHU_RrUD_p07vAO9tO2fFsylaAICWoJNmBngCzA0ixKlUhYV-Z6PPnE_iCBOieVP4iIcKTEHRKQ',
            e: 'AQAB'
          },
          {
            use: 'sig',
            kty: 'RSA',
            kid: '859c9e07-d416-82c8-2e03-3f047932598a',
            alg: 'RS256',
            n: 'yfjKV4eZ9US3MxjaIi-Zi6y_3dL1J_EsqSJ2DN11PcYWnRentjMfNZt28_0HnEwKrlOx3R01JgK38yUFpWJ-T_w7bKNbo3Z3XDi-5iknDcNJqL2g8lgkymRjHvpuchAUNqTZIzYxSqpR4fgGKUJUdrGuV6Vwom6ujB8pJiATOT-yuTR7sBm_Mi1XNDsAHuVoaZK4xYPfgqeUVNU1Ds0VmzJTh77SXgf6omfSKT-XNlPlFkQEz7J1Ht2hgPB-ipQwTAadqWPyMWnUG2Deceh0UG1fEyPpwQQG1UCH1yim4uoUNi8yXrM0XWgvAz3-60BYTn2wCQ43IX4fUvluaD8lFw',
            e: 'AQAB'
          }
        ]
      }
    end

    describe 'with cache' do
      subject { described_class.new ActiveSupport::Cache::NullStore.new }
      it 'fetches and returns a JWKS' do
        allow(subject).to receive(:fetch_keys).and_return(jwks)
        keys = subject.keys issuer
        expect(keys).to be_a Hash
      end
    end

    describe 'without cache' do
      it 'fetches and returns a JWKS' do
        allow(subject).to receive(:fetch_keys).and_return(jwks)
        keys = subject.keys issuer
        expect(keys).to be_a Hash
      end
    end
  end
end

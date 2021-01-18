# frozen_string_literal: true

RSpec.shared_context 'jwt' do
  let(:keys) do
    {
      keys: [
        {
          kty: 'RSA',
          n: 'nzyis1ZjfNB0bBgKFMSvvkTtwlvBsaJq7S5wA-kzeVOVpVWwkWdVha4s38XM_pa_yr47av7-z3VTmvDRyAHcaT92whREFpLv9cj5lTeJSibyr_Mrm_YtjCZVWgaOYIhwrXwKLqPr_11inWsAkfIytvHWTxZYEcXLgAXFuUuaS3uF9gEiNQwzGTU1v0FqkqTBr4B8nW3HCN47XUu0t8Y0e-lf4s4OxQawWD79J9_5d3Ry0vbV3Am1FtGJiJvOwRsIfVChDpYStTcHTCMqtvWbV6L11BWkpzGXSW4Hv43qa-GSYOD2QU68Mb59oSk2OB-BtOLpJofmbGEGgvmwyCI9Mw',
          e: 'AQAB',
          kid: 'i7ygo8yab78gfv'
        }
      ]
    }
  end

  let(:decoded_token) do
    {
      aud: 'aseuirvbh',
      exp: 9_609_995_501,
      iat: 1_609_995_201,
      iss: 'http://localhost',
      namespace: 'root',
      sub: 'n89q2cxf89q34bvyt'
    }
  end

  let(:token) do
    'eyJhbGciOiJSUzI1NiIsImtpZCI6Imk3eWdvOHlhYjc4Z2Z2In0.eyJhdWQiOiJhc2V1aXJ2YmgiLCJleHAiOjk2MDk5OTU1MDEsImlhdCI6MTYwOTk5NTIwMSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdCIsIm5hbWVzcGFjZSI6InJvb3QiLCJzdWIiOiJuODlxMmN4Zjg5cTM0YnZ5dCJ9.G9f-kkJJlxdlUpBU1tFaJy7BG-VC4JdEc-uYwVNpUxd3bubnAhtg2qsb1tgzDX1cMX8e7vUq3ykEjO4FUJlbwvGobbzFa9glXySsL_SrF4YxTNJvkmTjZe66VeS4kRZlKLFYmXfKWkSAxG9p6XcAoI3vesIeXsVZtWV-wrWJsXyqWzDG_ZImbs16INL9FaJsIZwiDLQaLIHCCYnk6OZIcK4vc4cjGmGSpaiedug1-_E9MdKu5BhJYaAQGH1Ktz8b3anCuCsrZQY4VcbM5y8ChzbadfOxlWqHjjaPCECyCSVcI9JA41AjehrcnPXwTemFgve-4H5TX8hqgwqcPnPTNQ'
  end

  let(:bad_token) do
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c'
  end
end

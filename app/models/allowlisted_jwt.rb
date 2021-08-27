class AllowlistedJwt < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Allowlist
end

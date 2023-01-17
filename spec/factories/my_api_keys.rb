# == Schema Information
#
# Table name: my_api_keys
#
#  id            :uuid             not null, primary key
#  encrypted_key :string           not null
#  key_cipher    :string           not null
#  key_salt      :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :my_api_key do
    transient { key { 'api_key' } }

    after(:build) { |my_api_key, evaluator| my_api_key.key = evaluator.key }
  end
end

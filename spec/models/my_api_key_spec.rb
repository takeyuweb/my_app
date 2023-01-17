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
require 'rails_helper'

RSpec.describe MyApiKey, type: :model do
  specify '作成時に key が必要であること' do
    my_api_key = MyApiKey.new
    expect(my_api_key).to_not be_valid
    expect(my_api_key.errors[:key]).to be_any

    my_api_key.key = ''
    expect(my_api_key).to_not be_valid
    expect(my_api_key.errors[:key]).to be_any

    my_api_key.key = 'KEY123'
    expect(my_api_key.key).to eq 'KEY123'
    expect(my_api_key.encrypted_key).to eq nil
    expect(my_api_key.key_salt).to eq nil

    expect(my_api_key).to be_valid
    expect(my_api_key.errors[:key]).to be_empty
    expect(my_api_key.save).to eq true
    expect(my_api_key.key).to eq 'KEY123'
    expect(my_api_key.encrypted_key).to_not eq nil
    expect(my_api_key.key_salt).to_not eq nil

    my_api_key_b = MyApiKey.create(key: 'api_key_b')
    expect(my_api_key_b.key).to eq 'api_key_b'
  end

  specify 'key を変更する場合にバリデーションを実施すること' do
    my_api_key = FactoryBot.create(:my_api_key, key: 'KEY456')
    expect(my_api_key.key).to eq 'KEY456'

    expect(my_api_key).to be_valid
    expect { my_api_key.save }.to_not change(my_api_key, :encrypted_key)
    my_api_key.key = 'KEY789'
    expect(my_api_key).to be_valid
    expect { my_api_key.save }.to change(my_api_key, :encrypted_key)
    expect(my_api_key.key).to eq 'KEY789'

    my_api_key.key = nil
    expect(my_api_key.key).to eq nil
    expect(my_api_key).to_not be_valid
    expect(my_api_key.errors[:key]).to be_any

    my_api_key.reload
    expect(my_api_key.key).to eq 'KEY789'
  end
end

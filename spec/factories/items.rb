# == Schema Information
#
# Table name: items
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  price      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :item do
    sequence(:name) { |i| "name #{i}" }
    price { rand(100..1000) }
  end
end

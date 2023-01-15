# == Schema Information
#
# Table name: backet_items
#
#  id         :uuid             not null, primary key
#  quantity   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  backet_id  :uuid             not null
#  item_id    :uuid             not null
#
# Indexes
#
#  index_backet_items_on_backet_id              (backet_id)
#  index_backet_items_on_backet_id_and_item_id  (backet_id,item_id) UNIQUE
#  index_backet_items_on_item_id                (item_id)
#
# Foreign Keys
#
#  fk_rails_...  (backet_id => backets.id)
#  fk_rails_...  (item_id => items.id)
#
FactoryBot.define do
  factory :backet_item do
    association :backet
    association :item
    quantity { rand(1..10) }
  end
end

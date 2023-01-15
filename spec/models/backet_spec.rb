# == Schema Information
#
# Table name: backets
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Backet, type: :model do
  describe '.items.with_quantity' do
    example do
      backet = FactoryBot.create(:backet)
      item_a = FactoryBot.create(:backet_item, backet: backet, quantity: 1).item
      item_b = FactoryBot.create(:backet_item, backet: backet, quantity: 5).item

      expect(backet.items.with_quantity.find(item_a.id).quantity).to eq 1
      expect(backet.items.with_quantity.find(item_b.id).quantity).to eq 5
      p backet.items.with_quantity.pluck(:id, :quantity)
    end
  end
end

# == Schema Information
#
# Table name: backets
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Backet < ApplicationRecord
  has_many :backet_items, dependent: :destroy
  has_many :items, through: :backet_items do
    def with_quantity
      select(:quantity, arel_table[Arel.star])
    end
  end
end

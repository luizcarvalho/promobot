class Promotion < ApplicationRecord
  validates :identifier, uniqueness: { scope: :origin }
end

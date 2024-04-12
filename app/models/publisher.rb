class Publisher < ApplicationRecord
  has_many :books

  scope :ordered_by_name, -> { order(name: :asc) }

end

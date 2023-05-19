class SearchEntry < ApplicationRecord
  delegated_type :searchable, types: %w[Section Space Item]
  validates :searchable_type, uniqueness: { scope: :searchable_id }
  validates :url, allow_blank: false, presence: true
end
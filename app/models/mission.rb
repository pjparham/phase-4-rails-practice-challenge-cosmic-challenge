class Mission < ApplicationRecord
    belongs_to :scientist
    belongs_to :planet

    validates :name, presence: true
    validates :scientist_id, presence: true, uniqueness: {scope: :name}
    validates :planet_id, presence: true
end

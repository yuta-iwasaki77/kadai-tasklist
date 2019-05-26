class Task < ApplicationRecord
    validates :task, presence: true, length: { maximum: 255 }
    validates :status, presence: true, length: { maximum: 10 }
end

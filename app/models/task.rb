class Task < ApplicationRecord
  belongs_to :user, optional: true
  scope :filter_by_status, ->(status, user_id) { where status: status, user_id: user_id }
  scope :filter_by_user_id, ->(user_id) { where user_id: user_id }
  extend ActiveModel::Naming
  extend Enumerize
  enumerize :status,
            in: { :todo => 1, :inprogress => 2, :done => 3 },
            default: :todo,
            predicates: true

  validates :title, presence: { message: "Title blank" }
  validates :title, length: { minimum: 5, message: "Title min 5 chars" }
  validates :description, presence: { message: "Description blank" }
  validates :description, length: { minimum: 10, message: "Description min 10 chars" }
end

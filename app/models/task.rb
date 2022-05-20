class Task < ApplicationRecord
  belongs_to :user

  extend ActiveModel::Naming
  extend Enumerize
  enumerize :status,
            in: { :todo => 1, :inprogress => 2, :done => 3 },
            default: :todo,
            predicates: true

  validates :title, presence: { message: "Title blank" },
                    length: { minimum: 5, message: "Title min 5 chars" }
  validates :description, presence: { message: "Description blank" },
                          length: { minimum: 10, message: "Description min 10 chars" }
end

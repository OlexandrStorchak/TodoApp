class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: { message: "Title blank" },
                    length: { minimum: 5, message: "Title min 5 chars" }
  validates :description, presence: { message: "Description blank" },
                          length: { minimum: 10, message: "Description min 10 chars" }
end

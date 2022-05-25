class User < ApplicationRecord
  extend ActiveModel::Naming
  extend Enumerize

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks, dependent: :destroy

  enumerize :role,
            in: { user: 1, admin: 2 },
            default: :user,
            predicates: true
end

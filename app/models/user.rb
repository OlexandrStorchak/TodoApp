class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  extend ActiveModel::Naming
  extend Enumerize

  enumerize :role,
            in: { :user => 1, :admin => 2 },
            default: :user,
            predicates: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

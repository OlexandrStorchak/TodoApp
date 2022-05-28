require 'ffaker'

FactoryBot.define do
  factory :task do
    title { FFaker::Lorem.phrase }
    description { FFaker::Lorem.paragraphs }
  end
end

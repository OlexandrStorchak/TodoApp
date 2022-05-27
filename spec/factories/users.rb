FactoryBot.define do
  factory :user do
    trait :user do
      id { 2 }
      email { 'user@user.com' }
      password { '123456' }
      role { 'user' }
    end
    trait :admin do
      id { 1 }
      email { 'admin@admin.com' }
      password { '654321' }
      role { 'admin' }
    end
  end
end

FactoryBot.define do
  factory :user do
    sequence(:name, "田中 太郎_1")
    sequence(:email) { |n| "test#{n}@example.com" }
    sequence(:tel) { |n| "000-1111-#{format("%04d", n)}" }
    sequence(:post_code) { |n| "000-#{format("%04d", n)}" }
    sequence(:address) { |n| "東京都新宿区市ヶ谷本村町5番#{n}号" }
  end
end

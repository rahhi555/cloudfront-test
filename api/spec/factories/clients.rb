# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { Gimei.name.kanji }
    email { Faker::Internet.email }
    tel { Faker::PhoneNumber.cell_phone }
    address { Gimei.address.kanji }
    postal { Faker::Address.postcode.delete('-') }
    password { Faker::Internet.password }
  end
end

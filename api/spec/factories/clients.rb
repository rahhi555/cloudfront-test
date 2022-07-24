FactoryBot.define do
  factory :client do
    provider { "email" }
    uid { "MyString" }
    encrypted_password { "MyString" }
    reset_password_token { "MyString" }
    reset_password_sent_at { "2020-07-24 12:34:56" }
    allow_password_change { false }
    confirmation_token { "MyString" }
    confirmed_at { "2020-07-24 12:34:56" }
    confirmation_sent_at { "2020-07-24 12:34:56" }
    unconfirmed_email { "MyString" }
    name { "MyString" }
    email { "MyString" }
    tel { "MyString" }
    post_code { "MyString" }
    address { "MyString" }
    tokens { "" }
  end
end

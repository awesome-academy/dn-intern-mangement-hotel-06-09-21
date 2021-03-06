FactoryBot.define do
  factory :user do
    email {Faker::Internet.email.downcase}
    password {"vansang12"}
    password_confirmation {"vansang12"}
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    phone {Faker::PhoneNumber.phone_number}
    address {Faker::Address.full_address}
    confirmed_at {Time.zone.now}
    role {1}
  end
end

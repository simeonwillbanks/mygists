# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    username "simeonwillbanks"
    gravatar_id "a624cb08e20db3ac4adb6380928a7b11"

    after(:build) { |p| p.token = MyGists::Secure.encrypt("token") }
    after(:stub) { |p| p.token = MyGists::Secure.encrypt("token") }
  end
end

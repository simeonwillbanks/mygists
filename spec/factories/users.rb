# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "GitHub"
    uid 163489
    association :profile, strategy: :build
  end
end

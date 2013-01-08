# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "GitHub"
    sequence(:uid) { |n| n }
    association :profile, strategy: :build
  end
end

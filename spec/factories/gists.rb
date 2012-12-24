# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gist do
    sequence(:title) {|n| "Tag#{n}: Gist Title" }
    sequence(:gid) {|n| "68c29f86f75b343953ef#{n}" }
    association :profile, strategy: :build
  end
end

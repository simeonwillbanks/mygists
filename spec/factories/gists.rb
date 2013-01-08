# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gist do
    sequence(:description) { |n| "#Tag#{n} Gist Title" }
    sequence(:gid) { |n| n.to_s }
    association :profile, strategy: :build
    public { true }
    starred { true }
  end
end

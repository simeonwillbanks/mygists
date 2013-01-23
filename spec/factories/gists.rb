# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gist do
    sequence(:description) { |n| "#Tag#{n} Gist Title" }
    sequence(:gid) { |n| n.to_s }
    public true
    starred true
    association :profile, strategy: :build

    trait :public do
      public true
    end

    trait :private do
      public false
    end

    ignore do
      tags ["Rails"]
    end

    after(:create) do |gist, evaluator|
      context = gist.public? ? "public" : "private"
      gist.description = "##{evaluator.tags.join(" #")} Gist Title"
      gist.profile.tag(gist, with: evaluator.tags, on: context)
    end
  end
end

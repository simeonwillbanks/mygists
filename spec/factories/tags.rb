# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag, class: ActsAsTaggableOn::Tag  do
    sequence(:name) { |n| "Tag#{n}" }
    sequence(:slug) { |n| "slug-#{n}" }
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    username "simeonwillbanks"
    #after(:build) do |profile|
    #  profile.gists << build_list(:gist, 3, profile: profile)
    #end
  end
end

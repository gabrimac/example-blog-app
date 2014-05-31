require 'faker'

FactoryGirl.define do
  factory :comment do
    username {Faker::Name.name}
    comment {Faker::Lorem.sentence}
    post
  end

  factory :invalid_comment, parent: :comment do
    comment nil
  end
end
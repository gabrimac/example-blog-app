require 'faker'

FactoryGirl.define do

  factory :post do
    title {Faker::Lorem.sentence}
    body { Faker::Lorem.paragraph }

    factory :post_with_comment do
      before(:create) do |post|
        create(:comment, post: post)
      end
    end
  end

  factory :invalid_post, parent: :post do
    title nil
  end

end
FactoryBot.define do
  factory :proposal do
    image            { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.png')) }
    title            { Faker::Lorem.sentence }
    where            { Faker::Lorem.sentence }
    what             { Faker::Lorem.sentence }
    why              { Faker::Lorem.sentence }
    how              { Faker::Lorem.sentence }
    before_seconds   { 50 }
    before_workers   { 10 }
    before_days      { 10 }
    before_man_hours { 10 }
    hourly_wage      { 1000 }
    before_costs     { 1000 }
    association :user
  end
end

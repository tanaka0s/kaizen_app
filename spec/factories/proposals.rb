FactoryBot.define do
  factory :proposal do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.png')) }
    title { Faker::Lorem.sentence }
    where { Faker::Lorem.sentence }
    what { Faker::Lorem.sentence }
    why { Faker::Lorem.sentence }
    how { Faker::Lorem.sentence }
    before_seconds { Faker::Number.between(from: 0, to: 1000) }
    before_workers { Faker::Number.between(from: 0, to: 1000) }
    before_days { Faker::Number.between(from: 0, to: 365) }
    before_man_hours { Faker::Number.between(from: 0, to: 1000) }
    hourly_wage { 1000 }
    before_costs { Faker::Number.between(from: 0, to: 1000) }
    association :user
  end
end

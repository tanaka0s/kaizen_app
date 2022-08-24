FactoryBot.define do
  factory :execution do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.png')) }
    where { Faker::Lorem.sentence }
    what { Faker::Lorem.sentence }
    why { Faker::Lorem.sentence }
    how { Faker::Lorem.sentence }
    after_seconds { Faker::Number.between(from: 0, to: 1000) }
    after_workers { Faker::Number.between(from: 0, to: 1000) }
    after_days { Faker::Number.between(from: 0, to: 365) }
    after_man_hours { Faker::Number.between(from: 0, to: 1000) }
    hourly_wage { 1000 }
    after_costs { Faker::Number.between(from: 0, to: 1000) }
    reduced_man_hours { Faker::Number.between(from: 0, to: 1000) }
    reduced_costs { Faker::Number.between(from: 0, to: 1000) }
    association :user
    association :proposal
  end
end

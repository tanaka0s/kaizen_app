FactoryBot.define do
  factory :proposal_estimation do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.png')) }
    title { Faker::Lorem.sentence }
    where { Faker::Lorem.sentence }
    what { Faker::Lorem.sentence }
    why { Faker::Lorem.sentence }
    how { Faker::Lorem.sentence }
    before_seconds { Faker::Number.between(from: 10, to: 100) }
    before_workers { Faker::Number.between(from: 10, to: 100) }
    before_days { Faker::Number.between(from: 1, to: 365) }
    before_man_hours { Faker::Number.between(from: 10, to: 100) }
    hourly_wage { 1000 }
    before_costs { Faker::Number.between(from: 10, to: 100) }
    after_seconds { Faker::Number.between(from: 1, to: 10) }
    after_workers { Faker::Number.between(from: 1, to: 10) }
    after_days { Faker::Number.between(from: 1, to: 365) }
    after_man_hours { Faker::Number.between(from: 1, to: 10) }
    after_costs { Faker::Number.between(from: 1, to: 10) }
    reduced_man_hours { Faker::Number.between(from: 1, to: 100) }
    reduced_costs { Faker::Number.between(from: 1, to: 100) }
  end
end

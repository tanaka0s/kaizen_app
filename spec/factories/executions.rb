FactoryBot.define do
  factory :execution do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.png')) }
    where { Faker::Lorem.sentence }
    what  { Faker::Lorem.sentence }
    why   { Faker::Lorem.sentence }
    how   { Faker::Lorem.sentence }
    after_seconds { 1 }
    after_workers { 1 }
    after_days { 10 }
    after_man_hours { 10 }
    hourly_wage { 1000 }
    after_costs { 10_000 }
    reduced_man_hours { 90 }
    reduced_costs { 90_000 }
    association :user
    association :proposal
  end
end

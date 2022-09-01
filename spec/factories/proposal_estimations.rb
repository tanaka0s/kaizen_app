FactoryBot.define do
  factory :proposal_estimation do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.png')) }
    title { Faker::Lorem.sentence }
    where { Faker::Lorem.sentence }
    what  { Faker::Lorem.sentence }
    why   { Faker::Lorem.sentence }
    how   { Faker::Lorem.sentence }
    before_seconds    { 125 }
    before_workers    { 10 }
    before_days       { 100 }
    before_man_hours  { 10 }
    hourly_wage       { 1000 }
    before_costs      { 1000 }
    after_seconds     { 25 }
    after_workers     { 10 }
    after_days        { 100 }
    after_man_hours   { 10 }
    after_costs       { 100 }
    reduced_man_hours { 10 }
    reduced_costs     { 1000 }
  end
end

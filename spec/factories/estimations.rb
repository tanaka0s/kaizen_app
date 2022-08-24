FactoryBot.define do
  factory :estimation do
    hourly_wage { 1000 }
    after_seconds { Faker::Number.between(from: 1, to: 10) }
    after_workers { Faker::Number.between(from: 1, to: 10) }
    after_days { Faker::Number.between(from: 1, to: 365) }
    after_man_hours { Faker::Number.between(from: 1, to: 10) }
    after_costs { Faker::Number.between(from: 1, to: 10) }
    reduced_man_hours { Faker::Number.between(from: 1, to: 100) }
    reduced_costs { Faker::Number.between(from: 1, to: 100) }
    association :proposal
  end
end

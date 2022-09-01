FactoryBot.define do
  factory :estimation do
    hourly_wage       { 1000 }
    after_seconds     { 20 }
    after_workers     { 10 }
    after_days        { 10 }
    after_man_hours   { 10 }
    after_costs       { 100 }
    reduced_man_hours { 10 }
    reduced_costs     { 1000 }
    association :proposal
  end
end

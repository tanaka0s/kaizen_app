class CreateEstimations < ActiveRecord::Migration[6.0]
  def change
    create_table :estimations do |t|
      t.references :proposal,          null: false, foreign_key: true
      t.integer    :after_seconds,     null: false
      t.integer    :after_workers,     null: false
      t.integer    :after_days,        null: false
      t.decimal    :after_man_hours,   null: false, precision: 10, scale: 1
      t.integer    :hourly_wage,       null: false
      t.integer    :after_costs,       null: false
      t.decimal    :reduced_man_hours, null: false, precision: 10, scale: 1
      t.integer    :reduced_costs,     null: false
      t.timestamps
    end
  end
end

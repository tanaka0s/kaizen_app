class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.references :user,             null: false, foreign_key: true
      t.text       :where,            null: false
      t.text       :what,             null: false
      t.text       :why,              null: false
      t.text       :how,              null: false
      t.integer    :before_seconds,   null: false
      t.integer    :before_workers,   null: false
      t.integer    :before_days,      null: false
      t.decimal    :before_man_hours, null: false, precision: 10, scale: 1
      t.integer    :hourly_wage,      null: false
      t.integer    :before_costs,     null: false
      t.timestamps
    end
  end
end

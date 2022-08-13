class AddTitleProposals < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :title, :string, null: false
  end
end

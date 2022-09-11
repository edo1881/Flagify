class CreateUserChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :user_challenges do |t|
      t.string :hint_timestamp
      t.string :flag_timestamp
      t.belongs_to :user,   null: false
      t.belongs_to :challenge, null: false
      t.timestamps
    end
  end
end

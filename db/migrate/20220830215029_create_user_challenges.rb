class CreateUserChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :user_challenges do |t|
      t.references :users, null: false, foreign_key: true
      t.references :challenges, null: false, foreign_key: true
      t.datetime :timestamp_flag
      t.datetime :timestamp_hint

      t.timestamps
    end
  end
end

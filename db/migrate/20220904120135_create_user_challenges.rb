class CreateUserChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :user_challenges do |t|
      t.string :hint_timestamp
      t.string :flag_timestamp
      t.belongs_to :user
      t.belongs_to :challenge
      t.timestamps
    end
  end
end

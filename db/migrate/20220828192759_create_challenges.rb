class CreateChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :challenges do |t|
      t.string :nome,     null: false
      t.string :testo
      t.integer :n_utenti_solv
      t.string :flag,     null: false
      t.string :url_image
      t.string :category, null: false
      t.string :hint
      t.integer :score,   default: 0
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end

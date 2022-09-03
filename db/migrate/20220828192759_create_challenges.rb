class CreateChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :challenges do |t|
      t.string :nome
      t.string :testo
      t.integer :n_utenti_solv
      t.string :flag
      t.string :url_image
      t.string :category
      t.string :hint
      t.integer :score

      t.timestamps
    end
  end
end

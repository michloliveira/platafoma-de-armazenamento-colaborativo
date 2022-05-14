class CreateCopia < ActiveRecord::Migration[5.2]
  def change
    create_table :copia do |t|
      t.references :user, foreign_key: true
      t.references :arquivo, foreign_key: true
      t.bigint :qntCopias

      t.timestamps
    end
  end
end

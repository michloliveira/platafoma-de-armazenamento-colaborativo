class CreateArquivos < ActiveRecord::Migration[5.2]
  def change
    create_table :arquivos do |t|
      t.text :image_data
      t.text :description
      t.timestamps
    end
  end
end

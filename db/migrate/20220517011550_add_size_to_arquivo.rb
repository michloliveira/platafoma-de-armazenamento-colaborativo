class AddSizeToArquivo < ActiveRecord::Migration[5.2]
  def change
    add_column :arquivos, :tamanho, :bigint
  end
end

class AddCriptoChaveToArquivo < ActiveRecord::Migration[5.2]
  def change
    add_column :arquivos, :cripto_chave, :string
  end
end

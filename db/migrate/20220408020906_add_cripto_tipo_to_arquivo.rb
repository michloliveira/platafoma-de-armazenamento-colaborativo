class AddCriptoTipoToArquivo < ActiveRecord::Migration[5.2]
  def change
    add_column :arquivos, :cripto_tipo, :string
  end
end

class AddHashMd5ToArquivo < ActiveRecord::Migration[5.2]
  def change
    add_column :arquivos, :hash_md5, :string
  end
end

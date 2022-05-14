class RemoveUserFromArquivo < ActiveRecord::Migration[5.2]
  def change
    remove_reference :arquivos, :user, foreign_key: true
  end
end

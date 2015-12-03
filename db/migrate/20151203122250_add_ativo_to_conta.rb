class AddAtivoToConta < ActiveRecord::Migration
  def change
    add_column :contas, :ativo, :boolean
  end
end

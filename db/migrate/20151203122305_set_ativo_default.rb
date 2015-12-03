class SetAtivoDefault < ActiveRecord::Migration
  def change
    change_column :contas, :ativo, :boolean, default: true
  end
end

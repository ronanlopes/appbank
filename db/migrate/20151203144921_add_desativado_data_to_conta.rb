class AddDesativadoDataToConta < ActiveRecord::Migration
  def change
    add_column :contas, :desativado_data, :date
  end
end

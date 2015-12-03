class RemoveDataFromMovimentacao < ActiveRecord::Migration
  def change
    remove_column :movimentacoes, :data, :datetime
  end
end

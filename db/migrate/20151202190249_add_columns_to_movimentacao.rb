class AddColumnsToMovimentacao < ActiveRecord::Migration
  def change
    add_column :movimentacoes, :conta_origem_id, :integer
    add_column :movimentacoes, :conta_destino_id, :integer
  end
end

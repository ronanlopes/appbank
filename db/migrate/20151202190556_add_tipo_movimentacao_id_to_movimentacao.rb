class AddTipoMovimentacaoIdToMovimentacao < ActiveRecord::Migration
  def change
    add_column :movimentacoes, :tipo_movimentacao_id, :integer
  end
end

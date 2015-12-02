class CreateTipoMovimentacoes < ActiveRecord::Migration
  def change
    create_table :tipo_movimentacoes do |t|
      t.string :nome

      t.timestamps null: false
    end
  end
end

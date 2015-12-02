class CreateMovimentacoes < ActiveRecord::Migration
  def change
    create_table :movimentacoes do |t|
      t.datetime :data
      t.integer :valor

      t.timestamps null: false
    end
  end
end

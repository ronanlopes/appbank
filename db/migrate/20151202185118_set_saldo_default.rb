class SetSaldoDefault < ActiveRecord::Migration
  def change
    change_column :contas, :saldo, :integer, default: 0
  end
end

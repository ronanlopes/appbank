class CreateContas < ActiveRecord::Migration
  def change
    create_table :contas do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :saldo

      t.timestamps null: false
    end
  end
end

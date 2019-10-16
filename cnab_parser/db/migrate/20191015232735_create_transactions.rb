class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :transaction_type
      t.datetime :date
      t.references :store, foreign_key: true
      t.string :store_owner
      t.decimal :value
      t.string :cpf
      t.string :card

      t.timestamps
    end
  end
end

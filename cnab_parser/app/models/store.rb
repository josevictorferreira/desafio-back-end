class Store < ApplicationRecord
  has_many :transactions, -> { order 'date ASC' }

  validates :name, presence: true
  validates_uniqueness_of :name
  validates_length_of :name, maximum: 14

  def balance
    transactions.reduce(0) do |sum, tran|
      if tran.transaction_type[:symbol] == '+'
        sum + tran.value
      else
        sum - tran.value
      end
    end
  end
end

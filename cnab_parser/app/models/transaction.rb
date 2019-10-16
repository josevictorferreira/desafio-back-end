class Transaction < ApplicationRecord
  belongs_to :store

  validates :value, :date, :store_owner, :store, :cpf, :card, :transaction_type, presence: true

  validates_length_of :cpf, minimum: 11, maximum: 11
  validates_length_of :card, minimum: 12, maximum: 12
  validates_length_of :store_owner, maximum: 19

  def date
    read_attribute(:date).strftime('%d/%m/%Y %H:%M:%S')
  end

  def value_str
    "#{transaction_type[:symbol]} %.2f" % read_attribute(:value)
  end

  def transaction_type
    TransactionType.data(read_attribute(:transaction_type))
  end

  class << self
    def create_transactions(full_data)
      full_data.each do |data|
        data[:store] = Store.first_or_create(name: data[:store])
        Transaction.create(data)
      end
    end
  end
end

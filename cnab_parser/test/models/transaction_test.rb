require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

  test 'should create a new transaction with valid data' do
    store = Store.first_or_create(name: 'Augusto Rod')
    transaction = Transaction.new({
      transaction_type: 1,
      value: 23.0,
      store_owner: 'Carlos',
      date: DateTime.now,
      cpf: '01234567890',
      card: '123456789012',
      store: store
    })
    assert transaction.valid?
    assert transaction.save
  end

  test 'should validate length of CPF attribute' do
    store = Store.first_or_create(name: 'Augusto Rod')
    transaction = Transaction.new({
      transaction_type: 1,
      value: 23.0,
      store_owner: 'Carlos',
      date: DateTime.now,
      cpf: '012345678901',
      card: '123456789012',
      store: store
    })
    assert !transaction.valid?
    assert !transaction.save
  end

  test 'should validate length of Store Owner attribute' do
    store = Store.first_or_create(name: 'Augusto Rod')
    transaction = Transaction.new({
      transaction_type: 1,
      value: 23.0,
      store_owner: 'Carlos Francisco Pereira',
      date: DateTime.now,
      cpf: '01234567890',
      card: '123456789012',
      store: store
    })
    assert !transaction.valid?
    assert !transaction.save
  end

  test 'should validate the presence of Store field' do
    transaction = Transaction.new({
      transaction_type: 1,
      value: 23.0,
      store_owner: 'Carlos',
      date: DateTime.now,
      cpf: '01234567890',
      card: '123456789012'
    })
    assert !transaction.valid?
    assert !transaction.save
  end

  test 'should insert multiples transactions' do
    store = Store.create({name: 'Marcos'})
    data = [
      {
        transaction_type: 1,
        value: 23.0,
        store_owner: 'Carlos',
        date: DateTime.now,
        cpf: '01234567890',
        card: '123456789012',
        store: store
      },
      {
        transaction_type: 1,
        value: 23.0,
        store_owner: 'Carlos',
        date: DateTime.now,
        cpf: '01234567890',
        card: '123456789012',
        store: store
      },
      {
        transaction_type: 1,
        value: 23.0,
        store_owner: 'Carlos',
        date: DateTime.now,
        cpf: '01234567890',
        card: '123456789012',
        store: store
      }
    ]
    Transaction.create_transactions(data)
    assert Transaction.all.count == 3
  end

  test "Transaction type should be given its data" do
    store = Store.first_or_create(name: 'Augusto Rod')
    Transaction.create({
      transaction_type: 1,
      value: 23.0,
      store_owner: 'Carlos',
      date: DateTime.now,
      cpf: '01234567890',
      card: '123456789012',
      store: store
    })
    new_t = Transaction.all().first()
    assert new_t.transaction_type[:kind] == 'Entrada'
    assert new_t.transaction_type[:description] == 'Débito'
    assert new_t.transaction_type[:symbol] == '+'
  end
end

require 'test_helper'

class StoreTest < ActiveSupport::TestCase

  test 'should save store with valid data' do
    store = Store.new({name: 'Augusto Rod'})
    assert store.valid?
    assert store.save
  end

  test 'store should be invalid with name with the wrong length' do
    store = Store.new({name: 'Augusto Rodrigo dos Santos Martins'})
    assert !store.valid?
    assert !store.save
  end

  test 'name should be a unique field' do
    store = Store.create({name: 'Augusto Rod'})
    sec_store = Store.new({name: 'Augusto Rod'})
    assert !sec_store.valid?
    assert !sec_store.save
  end

  test 'store must always have the name attribute setted' do
    store = Store.new({})
    assert !store.valid?
    assert !store.save
  end

  test 'transactions must come sorted by ascending date' do
    store = Store.create({name: 'Marcos'})
    t1 = Transaction.create({
      transaction_type: 1,
      value: 23.0,
      store_owner: 'Carlos',
      date: DateTime.now,
      cpf: '01234567890',
      card: '123456789012',
      store: store
    })
    t2 = Transaction.create({
      transaction_type: 1,
      value: 24.0,
      store_owner: 'Francisco',
      date: DateTime.now - 3.days,
      cpf: '01234567890',
      card: '123456789012',
      store: store
    })
    t3 = Transaction.create({
      transaction_type: 1,
      value: 25.0,
      store_owner: 'Rodrigo',
      date: DateTime.now - 1.day,
      cpf: '01234567890',
      card: '123456789012',
      store: store
    })
    new_store = Store.first_or_create(name: 'Marcos')
    assert new_store.transactions.first.store_owner == t2.store_owner
    assert new_store.transactions.last.store_owner == t1.store_owner
  end

  test 'balance must be calculated correctly' do
    store = Store.create({name: 'Marcos'})
    t1 = Transaction.create({
      transaction_type: 2,
      value: 23.0,
      store_owner: 'Carlos',
      date: DateTime.now,
      cpf: '01234567890',
      card: '123456789012',
      store: store
    })
    t2 = Transaction.create({
      transaction_type: 1,
      value: 24.0,
      store_owner: 'Francisco',
      date: DateTime.now - 3.days,
      cpf: '01234567890',
      card: '123456789012',
      store: store
    })
    t3 = Transaction.create({
      transaction_type: 1,
      value: 25.0,
      store_owner: 'Rodrigo',
      date: DateTime.now - 1.day,
      cpf: '01234567890',
      card: '123456789012',
      store: store
    })
    new_store = Store.first_or_create(name: 'Marcos')
    assert new_store.balance == 26.0
  end
end

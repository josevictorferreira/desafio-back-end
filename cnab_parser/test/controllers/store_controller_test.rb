require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  setup do
    @store = Store.create({name: 'Marcos'})
    Store.create({name: 'Francisco'})
    Store.create({name: 'Rodrigo'})
    t1 = Transaction.create({
      transaction_type: 1,
      value: 23.0,
      store_owner: 'Carlos',
      date: DateTime.now,
      cpf: '01234567890',
      card: '123456789012',
      store: @store
    })
    t2 = Transaction.create({
      transaction_type: 1,
      value: 24.0,
      store_owner: 'Francisco',
      date: DateTime.now - 3.days,
      cpf: '01234567890',
      card: '123456789012',
      store: @store
    })
    t3 = Transaction.create({
      transaction_type: 1,
      value: 25.0,
      store_owner: 'Rodrigo',
      date: DateTime.now - 1.day,
      cpf: '01234567890',
      card: '123456789012',
      store: @store
    })
  end

  test "should get index" do
    get stores_path
    assert_response :success
    assert_select 'tbody' do |elements|
      elements.each do |tbody|
        assert_select tbody, 'tr', 3
      end
    end
  end

  test "should get show, and list all transactions for the store" do
    get store_path(@store)
    assert_response :success
    assert_select 'tbody' do |elements|
      elements.each do |tbody|
        assert_select tbody, 'tr', 3
      end
    end
  end
end

require "test_helper"

class OperationTest < ActiveSupport::TestCase
  test "return true if everything is good" do
    operation = Operation.new(description:"Description_new", amount: 10.99, odate: DateTime.now, income: 1, category_id: Category.first.id, user_id: User.first.id)
    assert(operation.valid?)
  end

  test "return false if have no description " do
    operation = Operation.new(amount: 10.99, odate: DateTime.now, income: 0, category_id: Category.first.id, user_id: User.first.id)
    assert_not(operation.valid?)
  end

  test "return false if have no date " do
    operation = Operation.new(description:"Description_new",amount: 10.99, income: 0, category_id: Category.first.id, user_id: User.first.id)
    assert_not(operation.valid?)
  end
  test "return false if have no amount " do
    operation = Operation.new(description:"Description_new", odate: DateTime.now, income: 0, category_id: Category.first.id, user_id: User.first.id)
    assert_not(operation.valid?)
  end

  test "return false if have no category " do
    operation = Operation.new(description:"Description_new",amount: 10.99, odate: DateTime.now, income: 0, user_id: User.first.id)
    assert_not(operation.valid?)
  end

  test "return false if have no user" do
    operation = Operation.new(description:"Description_new",amount: 10.99, odate: DateTime.now, income: 0, category_id: Category.first.id)
    assert_not(operation.valid?)
  end


  test "test date if no more than now " do
    operation = Operation.new(description:"Description_new", amount: 10.99, odate: "2023-02-04 13:16:35".to_datetime, income: 1, category_id: Category.first.id, user_id: User.first.id)
    assert(operation.valid?)
  end

  test "test date if more than now " do
    operation = Operation.new(description:"Description_new", amount: 10.99, odate: "2023-02-27 13:16:35".to_datetime, income: 1, category_id: Category.first.id, user_id: User.first.id)
    assert_not(operation.valid?)
  end

  test "test date if last yer than now " do
    operation = Operation.new(description:"Description_new", amount: 10.99, odate: "2021-02-27 13:16:35".to_datetime, income: 1, category_id: Category.first.id, user_id: User.first.id)
    assert(operation.valid?)
  end
end

require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "check the 1st_Category from database" do
    category_first = Category.find_by(name: "1st_Category")
    assert_equal("1st_Category", category_first.name)
  end

  test "return false if name is missed" do
    new_category = Category.new(description: "5st_Category")
    assert_not(new_category.valid?)
  end

  test "return true if everything is good" do
    new_category = Category.new(name: "new category", description: "new description")
    assert_not(new_category.valid?)
  end


  test "check db get"do
    category_count = Category.find_by(name: "2nd_Category").operations.count
    assert_equal(category_count, 1)
  end
end

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "name cannot be nil" do
    error = assert_raises ActiveRecord::RecordInvalid do
      User.new(name: "", email: "rudiger@hey.com").save!
    end
    assert_equal "Validation failed: Name can't be blank", error.message
  end

  test "email cannot be blank" do
    error = assert_raises ActiveRecord::RecordInvalid do
      User.new(name: "Rudiger", email: "").save!
    end
    assert_equal "Validation failed: Email can't be blank", error.message
  end
end

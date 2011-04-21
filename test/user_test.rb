require 'test_helper'
require 'user'

class UserTest < Test::Unit::TestCase 
  
  def setup
     SunDawg::Responsys::User.clear_fields!
  end

  def test_attribute_methods
    SunDawg::Responsys::User.add_field :foo
    user = SunDawg::Responsys::User.new
    user.foo = "bar"
    assert_equal "bar", user.foo
    assert_equal "bar", user.FOO_
  end

  def test_responsys_fields
    SunDawg::Responsys::User.add_field :foo
    SunDawg::Responsys::User.add_field :bar
    assert_equal ["FOO_", "BAR_"], SunDawg::Responsys::User.responsys_fields
  end

  def test_values
    SunDawg::Responsys::User.add_field :foo
    SunDawg::Responsys::User.add_field :bar
    SunDawg::Responsys::User.add_field :nernt
    user = SunDawg::Responsys::User.new
    user.foo = "value_1"
    user.bar = "value_2"
    user.nernt = 123 
    assert_equal ["value_1", "value_2", 123], user.values
  end

  def test_attributes
    SunDawg::Responsys::User.add_field :foo
    SunDawg::Responsys::User.add_field :bar
    user = SunDawg::Responsys::User.new
    user.attributes = {:foo => "value_1", :bar => "value_2"}
    assert_equal "value_1", user.foo
    assert_equal "value_2", user.bar
  end

  def test_to_csv
    SunDawg::Responsys::User.add_field :email_address
    SunDawg::Responsys::User.add_field :first_name
    user = SunDawg::Responsys::User.new
    user.email_address = "sun.dawg@dawg.net"
    user.first_name = "Chris" 
    csv = SunDawg::Responsys::User.to_csv([user])
    assert_match "EMAIL_ADDRESS_,FIRST_NAME_", csv
    assert_match "sun.dawg@dawg.net,Chris", csv
  end
end
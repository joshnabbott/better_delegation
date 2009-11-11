require File.dirname(__FILE__) + '/spec_helper'

class BillingAddress < ActiveRecord::Base
  belongs_to :person
end

class Person < ActiveRecord::Base
  has_one :billing_address
  delegate :address_one, :is_primary_address, :to => :billing_address
end

describe "delegate" do
  before(:each) do
    @josh = Person.new(:name => 'Josh')
  end

  describe "Delegator" do
    it "should respond_to delegate" do
      ActiveRecord::Base.should respond_to('delegate')
    end
  end

  it "should not raise an error with a nil assocation" do
    lambda { @josh.address_one }.should_not raise_error(NoMethodError)
  end

  it "should create an empty instance of association when there's a nil association" do
    @josh.address_one
    @josh.billing_address.should_not be_nil
  end

  it "should return associations default value for method delegated to" do
    @josh.address_one.should be_nil
  end

  it "should return associations default value for method delegated to" do
    @josh.is_primary_address.should eql(false)
  end

  it "should return the value of the method delegated to" do
    @billing_address = @josh.build_billing_address(:address_one => '123 Happy Lane')
    @josh.address_one.should eql('123 Happy Lane')
  end
end
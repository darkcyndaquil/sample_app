require 'spec_helper'

describe User do
  
    
  #start of edit in chapter 6
  before do
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end
  #edited later in chapter 6
  subject { @user }
  
  it{should respond_to (:name)}
  it{should respond_to (:email)}
  #making column where user object responds to password_digest
  it{should respond_to (:password_digest)}
  #confirmation of password
  it{should respond_to (:password)}
  it{should respond_to (:password_confirmation)}  
  
  #authentication during login
  it {should respond_to (:authenticate)}
  
  
  it {should be_valid} #more of a sanity check
  #can now test the result by calling @user.valid?
  describe "when name is not present" do
	before { @user.name = " "}
	it {should_not be_valid}
  end
  #a failing test for validation of the name attribute
  describe "when email is not present:" do
    before {@user.email = " "}
	it {should_not be_valid}
  end
  
  #length validation
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
	it { should_not be_valid }
  end
  
  #formatting the email address so it will be valid
  describe "when email format is invalid" do
    it "should be invalid" do
	  addresses = %w[user@foo,com user_at_foo.org example.user@foo.
	                 foo@bar_baz.com foo@bar+baz.com]
	  addresses.each do |invalid_address|
	    @user.email = invalid_address
		expect(@user).not_to be_valid
	  end
	end
  end
  
  describe "when email format is valid" do
    it "should be valid" do
	  addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
	  addresses.each do |valid_address|
	    @user.email = valid_address
		expect(@user).to be_valid
	  end
	end
  end
  
  #to make sure that there are no blank passwords
  describe "when password is not present" do
    before do
	  @user = User.new(name: "Example User", email: "user@example.com", password: " ", password_confirmation: " ")
	end
	it {should_not be_valid}
  end
  
  #make sure the passwords match
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch"}
	it { should_not be_valid }
  end
  
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" *5}
	it {should be_invalid}
  end
  
  describe "return value of authenticate method" do
    before { @user.save }
	let(:found_user) { User.where(email: @user.email).first}
	
	describe "with valid password" do
	  it {should eq found_user.authenticate(@user.password)}
	end
	
	describe "with invalid password" do
	  let(:user_for_invalid_password) { found_user.authenticate("invalid")}
	 
	  it {should_not eq user_for_invalid_password }
	  specify {expect(user_for_invalid_password).to be_false}
	end
  end
  
end

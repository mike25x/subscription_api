require 'test_helper'
require 'factory_girl'


class ApiControllerTest < ActionController::TestCase

	test "create user"  do
		user_attributes =  {email: "tst@tst",app_id:1,last_login:Time.now,password:"123"}
		user = User.new(user_attributes)

		post :register_user, :user=> user_attributes
		
		saved_user = User.find_by(email:user.email)
		
		assert_response :success
		assert_equal  user.email,saved_user.email

		post :register_user, :user=> user_attributes
		
		assert_response :error
		assert_json("error_code",101)
		assert saved_user.password_hash.presence, "Nos se guardo el password"		
	end

	test "password reset" do
		password_user = FactoryGirl.create(:user)
		post :password_reset , {email:password_user.email ,app_id:password_user.app_id}
		assert_response :success
		assert_not_nil User.find(password_user.id).confirmation_hash
	end

	test "login working" do 
		new_user = FactoryGirl.create(:user,{password:"123"})

		post :login, :email=> new_user.email , :password => new_user.password
		assert_response :success

		post :login, :email=> new_user.email , :password => ""
		assert_response :missing
	end


	test "new subscription" do
		new_subscription = FactoryGirl.build(:subscription)

		post :add_subscription, :subscription=>new_subscription.attributes,:user_id=>new_subscription.user_id
		assert_response :success

		saved_subscription = Subscription.find(get_json["subscription"]["id"])
		assert_not_nil saved_subscription
		assert saved_subscription.end_date > Time.now + 1.hour

		post :add_subscription, :subscription=>new_subscription.attributes,:user_id=>new_subscription.user_id
		
		saved_subscription = Subscription.find(get_json["subscription"]["id"])

		assert (saved_subscription.end_date > Time.now + 1.year),"Year not added #{saved_subscription.end_date}"
	end


	test "get all subscriptions" do
		user = FactoryGirl.create(:user)
		3.times { FactoryGirl.create(:subscription,user_id:user.id) }

		get :all_subscriptions,:user_id=>user.id

		assert_response :success
		assert get_json['count'] > 0 
	end


	test "get 1 subscription" do
		user = FactoryGirl.create(:user)
		subscription = FactoryGirl.create(:subscription,user_id:user.id) 

		get :get_subscription,:user_id => user.id, subscription_type_id:subscription.subscription_type_id
		assert_response :success
		assert get_json['count']  ==  1 
	end

end

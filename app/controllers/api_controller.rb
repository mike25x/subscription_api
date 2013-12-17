class ApiController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
		logger.debug "index"
		render :text => "<b>status:</b><label style='color:blue'> up and running</label>"
	end

	def add_subscription
		new_subscription = Subscription.new(subscription_params)
		previous_subscription = Subscription.find_by(user_id:new_subscription.user_id,subscription_type_id:new_subscription.subscription_type_id)
	
		if previous_subscription
			new_subscription = previous_subscription
		else
			new_subscription.start_date = Time.now
			new_subscription.end_date = Time.now
		end
		
		new_subscription.end_date = new_subscription.end_date + 1.year
		new_subscription.save

		render :json => {status:"ok",subscription: new_subscription}
	end

	def all_subscriptions
		subscriptions = Subscription.where(user_id:params[:user_id])
		render :json => {subscriptions:subscriptions,count:subscriptions.count}
	end

	def get_subscription
		subscriptions = Subscription.where(user_id:params[:user_id],subscription_type_id:params[:subscription_type_id])
		render :json => {subscriptions:subscriptions , count:subscriptions.count}
	end


	def login
		if User.authenticate(params[:email],params[:password])
			render :json => {status:"ok"}
		else
			render :json => {status:"error", error_code:404, message:"user_not_found"},:status=> 404
		end		
	end

	def register_user
		user = User.new(user_params)
		
		user_db = User.find_by(email:user.email)
		
		if user_db
			render :json => {status:"error", error_code:101, message:"user_registered_previously"},:status=> 500 and return
		end

		
		user.save
		render :json => {status:user.email}
	end

	def password_reset
		user = User.find_by(email:params[:email],app_id:params[:app_id])
		user.confirmation_hash = SecureRandom.uuid.to_s
		user.save
		render :json => {status:"ok"}
	end

	def confirmation_email
		user = User.where(confirmation_hash:params[:confirmation_hash]).first
		user.activate = true
		user.save
		render :json => {status:"ok"}
	end

	private

	  def subscription_params
	    params.permit(:name,:subscription_type_id,:start_date,:receipt,:price)
	  end


	  def user_params
	  	params.require(:user).permit(:email,:last_login,:password,:app_idº)
	  end
end

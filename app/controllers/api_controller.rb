class ApiController < ApplicationController

	def index
		render :text => "<b>status:</b><label style='color:blue'> up and running</label>"
	end

	def add_subscription
		new_subscription = Subscription.new(subscription_params)
		render :json => {status:"ok"}
	end

	def all_subscriptions
		subscriptions = Subscription.where(user_id:params[:user_id])
		render :json => {subscriptions:subscriptions}
	end

	def get_subscription
		subscription = Subscription.where(user_id:params[:user_id],subscription_type_id:params[:subscription_type_id])
		render :json => {subscriptions:subscriptions}
	end

	def password_reset
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
	    params.permit(:name)
	  end
end

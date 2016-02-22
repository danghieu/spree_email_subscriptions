Dish::EmailSubscription.class_eval do
	def self.daily_email
		Dish::EmailSubscription.find_each do |email_subscription|
			EmailSubscriptionMailer.daily_email(email_subscription).deliver
		end
	end
end
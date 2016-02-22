class EmailSubscriptionMailer < ApplicationMailer
  

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.email_subscription_mailer.thankyou_email,.subject
  #
  def thankyou_email(email_subscription)
    
    @email_subscription = email_subscription
    @unsubscribe_url = "http://sheltered-stream-93214.herokuapp.com/#/main/email_subscrition?email=#{email_subscription.email}"
    

    mail to: email_subscription.email, subject: "Thank you for subscribing"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.email_subscription_mailer.daily_email.subject
  #
  def daily_email(email_subscription)
    
    @email_subscription = email_subscription
    @unsubscribe_url = "http://sheltered-stream-93214.herokuapp.com/#/main/email_subscrition?email=#{email_subscription.email}"
    available_ons = Dish::AvailableOn.where(delivery_date: Date.today)
    
    product_ids = available_ons.pluck(:product_id)
    
    @products = Spree::Product.where(id: product_ids)
    
    mail to: email_subscription.email, subject: "Daily dishes"
  end

  
end

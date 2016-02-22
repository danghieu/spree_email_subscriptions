module Spree
  module Api

class EmailSubscriptionsController < Spree::Api::BaseController
  before_action :set_email_subscription, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, :except => [:index, :show, :update, :create]

  def model_class
    Dish::EmailSubscription
  end

  # GET /email_subscriptions
  def index
    @email_subscriptions = Dish::EmailSubscription.all
    render "spree/api/email_subscriptions/index"
  end

  # GET /email_subscriptions/1
  def show
    render "spree/api/email_subscriptions/show"
  end

  # GET /email_subscriptions/new
  # def new
  #   @email_subscription = EmailSubscription.new
  # end

  # GET /email_subscriptions/1/edit
  # def edit
  # end

  # POST /email_subscriptions
  def create
    @email_subscription = Dish::EmailSubscription.new(email_subscription_params)

    if @email_subscription.save
    EmailSubscriptionMailer.thankyou_email(@email_subscription).deliver  
    @status = [ { "messages" => "Email subscription was successfully created"}]
          
    else
      @status = [ { "messages" => "Email subscription was not successfully created"}]
    end
    render "spree/api/logger/log", status: 201
  end

  # PATCH/PUT /email_subscriptions/1
  def update
    if @email_subscription.update(email_subscription_params)
      
      @status = [ { "messages" => "Email subscription was successfully updated"}]
          
    else
      @status = [ { "messages" => "Email subscription was not successfully updated"}]
    end
    render "spree/api/logger/log", status: 201
  end

  # DELETE /email_subscriptions/1
  def destroy
    @email_subscription.destroy
    redirect_to email_subscriptions_url, notice: 'Email subscription was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_subscription
      @email_subscription = Dish::EmailSubscription.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def email_subscription_params
      params.require(:email_subscription).permit(:email, :is_active)
    end
end
end
end

class ContactController < ApplicationController
  include SimpleCaptcha::ControllerHelpers
  def form
    render :template => "contact/form.html.erb", :layout => false
  end
  
  def index
    @message = Message.new
  end

  def post
    result = {'success' => 0 }

    # Construct new message using the POST data via message model
    @message = Message.new(
      :name => params[:name],
      :email => params[:email],
      :email_confirmation => params[:email_confirmation],
      :subject => params[:subject],
      :message => params[:message]
    )

    # Check model's validation result
    if @message.valid?
      # If message contents validate, proceed to check captcha
      if simple_captcha_valid?
        # Construct body of email
        body = "New message received from #{t :company_name} website:\n\n"\
              "From: #{params[:name]}\n"\
              "Company: #{params[:company]}\n"\
              "Email: #{params[:email]}\n"\
              "Phone: #{params[:phone]}\n"\
              "Message: #{params[:message]}"

        # Use sendmail
        Mail.defaults do
          delivery_method :sendmail
        end

        # Map of email subjects based on form select value
        subjects = {'1' => t(:customer_enquiry), '2' => t(:technical_support), '3' => t(:general_enquiry)}

        # Construct and send the message
        Mail.new(
        :to      => "#{$company_contact} <#{$admin_email}>",
        :from    => "#{$company_name} Website <#{$from_email}>",
        :subject => subjects[params[:subject]],
        :body    => body
        ).deliver!

        result = {'success' => '1' }
      else
        @invalid = {:captcha => ["#{t(:incorrect_captcha)}"]}
        result = {'success' => '0', 'message' => t(:incorrect_captcha), 'invalid' => @invalid}
      end
    else
      result = {'success' => '0', 'message' => t(:please_check_form), 'invalid' => @message.errors}
    end
    # Return results to AJAX listener
    render :json => result
  end
end

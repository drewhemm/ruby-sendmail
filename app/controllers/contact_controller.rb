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

    @message = Message.new(
      :name => params[:name],
      :email => params[:email],
      :email_confirmation => params[:email_confirmation],
      :subject => params[:subject],
      :message => params[:message]
    )

    if @message.valid?
      if simple_captcha_valid?
        body = "New message received from #{t :company_name} website:\n\n"\
              "From: #{params[:name]}\n"\
              "Company: #{params[:company]}\n"\
              "Email: #{params[:email]}\n"\
              "Phone: #{params[:phone]}\n"\
              "Message: #{params[:message]}"

        Mail.defaults do
          delivery_method :sendmail
        end

        subjects = {'1' => t(:customer_enquiry), '2' => t(:technical_support), '3' => t(:general_enquiry)}

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
      result = {'success' => '0', 'message' => 'Please check form', 'invalid' => @message.errors}
    end
    render :json => result
  end
end

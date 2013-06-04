class Message

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :name, :email, :email_confirmation, :subject, :message

  validates :name, :email, :email_confirmation, :subject, :message, :presence => true
  # Confirms that value of email field matches email confirmation field
  validates_confirmation_of :email, :message => I18n.t(:email_no_match)
  validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true
  # @todo Add domain MX lookup validation 
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end

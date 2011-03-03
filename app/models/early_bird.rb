class EarlyBird < ActiveRecord::Base
  validates_presence_of   :email, :message => "We need an email address to keep in touch with you."
  validates_uniqueness_of :email, :message => "Sorry, but you have already subscribed with this email address."
  validates_format_of     :email, :message => "We need a valid email address to keep in touch with you.",
    :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :allow_blank => true

  before_create :generate_code

  private
    def generate_code
      self.code = unique_code
    end

    # borrowed by Devise
    def unique_code #:nodoc:
      loop do
        code = Devise.friendly_token
        break code unless self.class.find(:first, :conditions => { :code => code })
      end
    end
end

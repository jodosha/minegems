class EarlyBird < ActiveRecord::Base
  validates_presence_of   :email, :message => "We need an email address to keep in touch with you."
  validates_uniqueness_of :email, :message => "Sorry, but you have already subscribed with this email address."
  validates_format_of     :email, :message => "We need a valid email address to keep in touch with you.",
    :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :allow_blank => true

  before_create :set_code

  def send_registration_code
    Beta.registration_code(self).deliver
  end

  private
    def set_code
      self.code ||= generate_code
    end

    # borrowed by Devise
    def generate_code #:nodoc:
      loop do
        code = Devise.friendly_token
        break code unless self.class.find(:first, :conditions => { :code => code })
      end
    end
end

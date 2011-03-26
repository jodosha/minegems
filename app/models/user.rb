class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # TODO privatebeta remove `deploy` flag when private beta will stop
  attr_accessor :login, :registration_code, :deploy
  attr_accessible :name, :email, :username, :login, :password, :password_confirmation, :remember_me, :registration_code, :deploy

  has_many :memberships, :dependent => :destroy
  has_many :subdomains, :through => :memberships

  validates_presence_of   :name, :username
  validates_uniqueness_of :email, :username, :case_sensitive => false
  validate :registration_code_presence, :on => :create
  after_create :reset_registration_code

  def self.search(query)
    where(:username => query).select([:username]).limit(1).first
  end

  def create_with_subdomain!(subdomain)
    return false unless new_record? or valid?
    subdomain = self.subdomains.build(subdomain)

    if subdomain.valid?
      save && subdomain.save and return true
    end
  end

  protected
    def self.find_for_database_authentication(conditions)
      login = conditions.delete(:login)
      where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
    end

    # Attempt to find a user by it's email. If a record is found, send new
    # password instructions to it. If not user is found, returns a new user
    # with an email not found error.
    def self.send_reset_password_instructions(attributes={})
      recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
      recoverable.send_reset_password_instructions if recoverable.persisted?
      recoverable
    end

    def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
       case_insensitive_keys.each { |k| attributes[k].try(:downcase!) }

       attributes = attributes.slice(*required_attributes)
       attributes.delete_if { |key, value| value.blank? }

       if attributes.size == required_attributes.size
         if attributes.has_key?(:login)
            login = attributes.delete(:login)
            record = find_record(login)
         else
           record = where(attributes).first
         end
       end

       unless record
         record = new

         required_attributes.each do |key|
           value = attributes[key]
           record.send("#{key}=", value)
           record.errors.add(key, value.present? ? error : :blank)
         end
       end
       record
     end

    def self.find_record(login)
      where(attributes).where(["username = :value OR email = :value", { :value => login }]).first
    end

    private
      def registration_code_presence
        return true if self.deploy

        if registration_code.blank?
          errors.add(:registration_code, "can't be blank")
        else
          early_bird = EarlyBird.first(:conditions => ['email = ? AND code = ?', email, registration_code])
          errors.add(:registration_code, "is invalid") if early_bird.nil?
        end
      end

      def reset_registration_code
        return true if self.deploy

        early_bird = EarlyBird.first(:conditions => ['email = ? AND code = ?', email, registration_code])
        early_bird.update_attributes :code => nil, :activated_at => Time.now
      end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :memberships, :dependent => :destroy
  has_many :subdomains, :through => :memberships

  validates_presence_of   :name
  validates_uniqueness_of :email, :case_sensitive => false

  def create_with_subdomain!(subdomain)
    return false unless new_record? or valid?
    subdomain = self.subdomains.build(subdomain)

    if subdomain.valid?
      save && subdomain.save and return true
    end
  end
end

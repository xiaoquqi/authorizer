require "digest"
require "digest/sha1"
class User < ActiveRecord::Base
  has_many :permissions, :dependent => :destroy

  validates :login,
    :presence => true,
    :uniqueness => { :case_sensitive => false },
    :length => 3..40
  validates :password,
    :presence => true,
    :length => 4..40,
    :if => :password_required?
  before_save :encrypt_password

  # Virtual attribute for the unencrypted password
  attr_accessor :password
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :password, :password_confirmation

  # Authenticates a user by their login name and unencrypted password.  
  # Returns the user or nil.
  def self.authenticate( login, password )
    logger.debug( "login #{login} : ENTER" )
    user = nil  # the default return
    u = find_by_login( login.downcase )
    if u && u.authenticated?( password )
      logger.debug( "login #{login} : authenticated locally" )
      user = u
    end # end if
    logger.debug( "login #{login} : RETURN #{u}" )
    return user
  end # end def self.authenticate

  # Encrypts some data with the salt.
  def self.encrypt( password, salt )
    Digest::SHA1.hexdigest( "--#{salt}--#{password}--" )
  end

  # Encrypts the password with the user salt
  def encrypt( password )
    self.class.encrypt( password, salt )
  end

  # authenticate user password
  def authenticated?( password )
    crypted_password == encrypt( password )
  end

  # before filter
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest( "--#{Time.now.to_s}--#{login}--" ) if new_record?
    self.crypted_password = encrypt( password )
  end

  # password required
  def password_required?
    crypted_password.blank? || !password.blank?
  end
end

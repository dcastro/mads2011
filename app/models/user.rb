class User < ActiveRecord::Base
  has_many :roles
  
  validates :username, :uniqueness => true
  validates :username, :name, :email, :presence => true
  
  
  validates :password, :confirmation => true #checks if the "type your pw" and "re-type your pw" fields match
  attr_accessor  :password_confirmation
  attr_reader   :password

  validate :password_must_be_present
  
  private
  def password_must_be_present
    errors.add(:password, "Missing password") unless hashed_password.present?
  end

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  public
  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + 'wibble' + salt)
  end

  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  def User.authenticate(username, password)
    if user = find_by_username(username)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end
  
end

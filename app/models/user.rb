class User < ActiveRecord::Base
  has_many :roles, :dependent => :destroy
  has_many :projects, :through => :roles
  has_many :suggestion_scenarios, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "30x30>" }, 
                    :default_url   => "/assets/new_user.png"
  
  validates :username, :uniqueness => true
  validates :username, :name, :email, :presence => true
  
  
  validates :password, :confirmation => true #checks if the "type your pw" and "re-type your pw" fields match
  attr_accessor  :password_confirmation
  attr_reader   :password

  validate :password_must_be_present
  
  
  def role_in_project(project_id)
    
    self.roles.where(project_id: project_id).first.name
    
  end
  
  
  def get_photo
    self.photo.url(:thumb)
  end
  
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

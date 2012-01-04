class Project < ActiveRecord::Base
  has_many :roles, :dependent => :destroy
  has_many :users, :through => :roles
  has_many :features, :dependent => :destroy
  has_many :scenarios, :through => :features
  has_many :suggestion_scenarios, :through => :features
  has_many :implemented_steps, :dependent => :destroy
  
  validates :name, :github_username, :github_repo, :presence => true
  
  #after_initialize :set_default_script
  
  #def set_default_script
  #  self.script = "bundle install\r\nbundle exec rake db:setup RAILS_ENV=test"
  #end
  
  def add_colaborators
    colabs = https_request "https://api.github.com/repos/#{ self.github_username }/#{ self.github_repo }/collaborators"
    n_invitations = 0
    
    colabs.each do |colab|

      git_user = https_request 'https://api.github.com/users/' + colab["login"]
      if git_user["email"]
        
        if user = User.find_by_email(git_user["email"])
            self.roles.build name: Role.role_types.second,
                            user: user
            n_invitations += 1
        end
        
      end
    
    end
    return n_invitations
  end
  
  def get_git_url
    "http://github.com/#{ self.github_username }/#{ self.github_repo }.git"
  end
  
  def download
    
    self.clean_up
    
    str = "git clone " + self.get_git_url + " tmp/projects/" + self.id.to_s
    %x[#{str}]
  end
  
  def clean_up
    FileUtils.rm_rf "tmp/projects/" + self.id.to_s    
  end
  
  
  def get_stats
    self.features.collect do |f| 
      [f.name, (f.scenarios.count > 0)? (f.scenarios.where(:completed => true).count.to_f / f.scenarios.count.to_f) : 0]
    end
  end
  
  def percentage_done 
    
    if self.scenarios.empty?
      return "No scenarios yet."
    else
      perc = self.scenarios.where(:completed => true).count.to_f / self.scenarios.count.to_f * 100
      perc = perc.to_i if perc == perc.to_i
      return perc.to_s + '%'
    end
    
  end
  
  
  private
  def https_request(uri)
    uri = URI(uri)
  
    http = Net::HTTP.new(uri.host, uri.port)
  
    if uri.scheme =='https'
      http.use_ssl = true
    end
  
    http.start do
      @request = Net::HTTP::Get.new(uri.request_uri)
      #puts http.request(request)
    end
    return ActiveSupport::JSON.decode(http.request(@request).body)
  end
  
  
end

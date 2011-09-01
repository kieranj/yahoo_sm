module YahooSM
      
  class Client
    
    def initialize(username, password, license, master_account_id)
      @username          = username
      @password          = password
      @license           = license
      @master_account_id = master_account_id
    end
    
    attr_reader   :username, :password, :license, :master_account_id
    
    attr_accessor :account_id, :master_account_location, :on_behalf_of_username, :on_behalf_of_password
    
    def on_behalf_of?
      !on_behalf_of_username.nil? && !on_behalf_of_password.nil?
    end
        
    def master_account_location
      @master_account_location ||= LocationService.new(self).master_account_location
    end
        
  end
  
end
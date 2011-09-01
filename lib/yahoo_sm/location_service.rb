module YahooSM
  
  class LocationService < Base  
      
    # Returns the URL prefix for the colocation your master account is assigned to.
    #
    # @return [String] the url prefix
    #
    def master_account_location
      perform_request(:get_master_account_location)
    end
    
  end
  
end
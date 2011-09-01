module YahooSM
  
  class API
  
    def initialize(client)
      @client = client
    end
  
    def service(name)
      klass = YahooSM.const_defined?(name) ? YahooSM.const_get(name) : YahooSM.const_missing(name)
      klass.new(@client)
    end
    
  end
  
end
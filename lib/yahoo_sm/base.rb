module YahooSM
  
  class Base
    
    def initialize(client)
      @client = client
    end
              
    private
    
      # Performs a request against the API
      #
      # @param [String] the name of the action to call
      # @param [Hash] options include the request body
      # @return [String] xml
      #
      def perform_request(action, options = {})
        response = client.request API_VERSION, action do
          soap.header = headers
          soap.body   = options[:body] unless options[:body].nil?
        end
        handle_response(response, action)
      end
    
      def handle_response(response, action)
        out = response.to_hash[:"#{action}_response"][:out]
        out.delete(:@xmlns) if out.is_a?(Hash) && out.key?(:@xmlns)
        out
      end
      
      def client
        @soap_client ||= begin
          klass  = self.class.name.split("::").last
          client = Savon::Client.new do
            if klass == "LocationService"
              wsdl.document  = "http://developer.searchmarketing.yahoo.com/docs/V7/wsdl/V7/LocationService.wsdl"
            else
              wsdl.endpoint  = endpoint
              wsdl.namespace = "http://marketing.ews.yahooapis.com/#{API_VERSION.upcase}"
            end
          end
          client.wsse.credentials @client.username, @client.password
          client
        end
      end

      def endpoint
        File.join(@client.master_account_location, "V7", self.class.name.split("::").last)
      end
      
      def headers
        headers = {
          "#{API_VERSION}:license"         => @client.license,
          "#{API_VERSION}:masterAccountID" => @client.master_account_id
        }

        headers.merge!({
          "#{API_VERSION}:onBehalfOfUsername" => @client.on_behalf_of_username,
          "#{API_VERSION}:onBehalfOfPassword" => @client.on_behalf_of_password
        }) if @client.on_behalf_of?

        headers
      end
    
  end
  
end
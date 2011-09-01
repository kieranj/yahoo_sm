require "savon"

Savon.configure do |config|
  config.log       = false
  config.log_level = :info
end

require "yahoo_sm/api"
require "yahoo_sm/client"
require "yahoo_sm/base"
require "yahoo_sm/location_service"
require "yahoo_sm/file_output_format"
require "yahoo_sm/basic_report_request"
require "yahoo_sm/basic_report_service"
require "yahoo_sm/report_info"
require "yahoo_sm/report_download_info"

module YahooSM
  
  API_VERSION = "v7"
  
end
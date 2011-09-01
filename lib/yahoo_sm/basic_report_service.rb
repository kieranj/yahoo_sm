module YahooSM
  
  class BasicReportService < Base
    
    # Creates a report
    #
    # @param [Integer] the spend account id
    # @param [BasicReportRequest] the report request
    # @param [FileOutoutFormat] the report file output format
    # @return [Integer] the report id
    #
    def add_report_request(account_id, report_request, file_output_format)
      body = {
        "#{API_VERSION}:accountID"        => account_id,
        "#{API_VERSION}:reportRequest"    => report_request.to_hash,
        "#{API_VERSION}:fileOutputFormat" => file_output_format.to_hash
      }
      perform_request(:add_report_request, { :body => body } )
    end
    
    # Deletes the specified report
    #
    # @param [Integer] the report id
    #
    def delete_report(report_id)
      perform_request(:delete_report, { :body => { "#{API_VERSION}:reportID" => report_id } })
    end
    
    # Deletes the specified reports
    #
    # @param [Array] the report ids
    #
    def delete_reports(report_ids)
      report_ids = wrap_report_ids(report_ids)
      perform_request(:delete_reports, { :body => { "#{API_VERSION}:reportIDs" => report_ids } })
    end
    
    # Returns the books closed time in UTC
    #
    # @param [BasicReportType] the report type
    # @return [DateTime]
    #
    def get_books_closed_time(report_type)
      perform_request(:get_books_closed_time, { :body => { "#{API_VERSION}:reportType" => report_type } })
    end
    
    # Returns the download the url for the specified report
    #
    # @param [Integer] the report id
    # @return [ReportDownloadInfo]
    #
    def get_report_download_url(report_id)
      response = perform_request(:get_report_download_url, { :body => { "#{API_VERSION}:reportID" => report_id } })
      ReportDownloadInfo.new(response)
    end
    
    # Returns the download the url for the specified reports
    #
    # @param [Array] the report ids
    # @return [Array] ReportDownloadInfo for each report_id
    #
    def get_report_download_urls(report_ids)
      report_ids = wrap_report_ids(report_ids)
      
      response = perform_request(:get_report_download_urls, { :body => { "#{API_VERSION}:reportIDs" => report_ids } })
      response.inject([]) do |result, item|
        result << ReportDownloadInfo.new(item[1])
        result
      end
    end
    
    # Returns a list of all requested reports you have access to in the master account
    #
    # @param [Boolean] if true returns only complete reports
    # @return [Array] ReportInfo for each report returned
    #
    def get_report_list(only_complete = false)
      response = perform_request(:get_report_list, { :body => { "#{API_VERSION}:onlyCompleted" => only_complete } })
      response.inject([]) do |result, item|
        result << ReportInfo.new(item[1])
        result
      end
    end
    
    # Returns the status of books closed
    #
    # @param [BasicReportRequest] the report request
    # @return [Boolean]
    #
    def is_books_closed(report_request)
      perform_request(:is_books_closed, { :body => { "#{API_VERSION}:reportRequest" => report_request } })
    end
    
    private
    
      def wrap_report_ids(report_ids)
        report_ids.inject([]) do |result, id|
          result << { "#{API_VERSION}:long" => id }
          result
        end
      end
    
  end
  
end
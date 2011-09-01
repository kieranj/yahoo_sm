module YahooSM
  
  class ReportDownloadInfo
    
    attr_reader :download_url, :file_output_format, :report_id, :report_status
    
    # Returns a hash of report download attributes
    #
    # @param [Hash]
    #
    def initialize(hash)
      @download_url       = hash[:download_url]
      @file_output_format = FileOutputFormat.new(hash[:file_output_format][:file_output_type], hash[:file_output_format][:zipped])
      @report_id          = hash[:report_id]
      @report_status      = hash[:report_status]
    end
    
  end

end
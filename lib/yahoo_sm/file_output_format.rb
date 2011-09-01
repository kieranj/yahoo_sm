module YahooSM
  
  class FileOutputFormat
    
    FILE_OUTPUT_TYPES = %W(CSV CSV_EXCEL TSV XML)
    
    attr_reader :file_output_type, :zipped
    
    def initialize(file_output_type, zipped = true)
      @file_output_type = file_output_type
      @zipped           = zipped
    end
    
    def to_hash
      {
        "#{API_VERSION}:fileOutputType" => @file_output_type,
        "#{API_VERSION}:zipped"         => @zipped
      }
    end
    
  end
  
end
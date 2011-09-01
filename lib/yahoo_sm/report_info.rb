module YahooSM
  
  class ReportInfo
    
    attr_reader :create_date, :report_id, :report_name, :status
    
    def initialize(hash)
      @create_date = hash[:create_date]
      @report_id   = hash[:report_id]
      @report_name = hash[:report_name]
      @status      = hash[:status]
    end
    
  end
  
end
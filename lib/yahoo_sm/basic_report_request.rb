module YahooSM
  
  class BasicReportRequest
    
    BASIC_REPORT_TYPES = [
      "AccountSummary",
      "AccountSummaryByDay",
      "AdDeliverySummary",
      "AdDeliveryByDay",
      "AdGroupSummary",
      "AdGroupSummaryByDay",
      "AdKeywordSummary",
      "AdKeywordSummaryByDay",
      "AdSummary",
      "AdSummaryByDay",
      "AdvancedAdKeywordPerformance",
      "AdvancedAdKeywordPerformanceByDay",
      "AdvancedAdPerformance",
      "AdvancedAdPerformanceByDay",
      "BillingTransactionDetail",
      "CampaignSummary",
      "CampaignSummaryByDay",
      "ClickFilterAccountSummary",
      "ClickFilterAccountSummaryByDay",
      "ClickFilterCampaignSummary",
      "ClickFilterCampaignSummaryByDay",
      "DailySummary",
      "DayPartingAdGroupSummary",
      "DayPartingAdGroupSummaryByDay",
      "DayPartingCampaignSummary",
      "DayPartingCampaignSummaryByDay",
      "DemoAgeAdGroupSummary",
      "DemoAgeAdGroupSummaryByDay",
      "DemoAgeCampaignSummary",
      "DemoAgeCampaignSummaryByDay",
      "DemoGenderAdGroupSummary",
      "DemoGenderAdGroupSummaryByDay",
      "DemoGenderCampaignSummary",
      "DemoGenderCampaignSummaryByDay",
      "GeoLocationAdGroupSummary",
      "GeoLocationAdGroupSummaryByDay",
      "GeoLocationSummary",
      "GeoLocationSummaryByDay",
      "KeywordSummary",
      "KeywordSummaryByDay",
      "MultiChannelAccount",
      "MultiChannelAccountByDay",
      "MultiChannelAdGroup",
      "MultiChannelAdGroupByDay",
      "MultiChannelCampaign",
      "MultiChannelCampaignByDay",
      "MultiChannelDaily",
      "MultiChannelMarketingActivity",
      "MultiChannelMarketingActivityByDay",
      "NetworkDistributionAdGroupSummary",
      "NetworkDistributionAdGroupSummaryByDay",
      "NetworkDistributionCampaignSummary",
      "NetworkDistributionCampaignSummaryByDay",
      "NetworkDistributionKeywordSummary",
      "NetworkDistributionKeywordSummaryByDay"
    ]
    
    #
    # @param [String] the name of the report
    # @param [ReportType] the report type
    #
    def initialize(name, report_type)
      @name         = name
      @report_type  = report_type
      @start_date   = nil
      @end_date     = nil
      @campaign_ids = []
    end
    
    attr_reader :start_date, :end_date, :campaign_ids
    
    # @param [DateTime] the start date of the report
    #
    def start_date=(date)
      @start_date = (date.is_a?(String) ? date : date.utc.strftime("%Y-%m-%dT00:00:00+00:00"))
    end
    
    # @param [DateTime] the end date of the report
    #
    def end_date=(date)
      @end_date = (date.is_a?(String) ? date : date.utc.strftime("%Y-%m-%dT00:00:00+00:00"))
    end
    
    # @param [Array] the list of campaignIDs to fetch, if any
    #
    def campaign_ids=(ids)
      @campaign_ids = ids
    end
    
    # Returns a hash the report request attributes
    #
    # @return [Hash]
    #
    def to_hash
      campaign_ids = @campaign_ids.inject([]) do |result, id|
        result << { "#{API_VERSION}:long" => id }
        result
      end
      
      result = {
        "#{API_VERSION}:reportName"  => @name,
        "#{API_VERSION}:reportType"  => @report_type,
        "#{API_VERSION}:startDate"   => @start_date,
        "#{API_VERSION}:endDate"     => @end_date,
        "#{API_VERSION}:campaignIDs" => (campaign_ids.empty? ? nil : campaign_ids)
      }
      result
    end
    
  end
  
end
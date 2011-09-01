# YahooSM

This gem provides a ruby interface to Yahoo Search Marketing.

## Notes

I currently only require the reporting functionality so this gem is currently limited to that.
If you'd like to extend it to cover more of the api, pull requests would be welcomed.

## Installation

    gem install yahoo_sm
    
## Getting Started

### Configuring up the client

To configure the client you'll need to create an instance of YahooSM::Client. This takes you username, password, license and master_account_id as arguments.
    
    client = YahooSM::Client.new("your_username", "secret", "1234567890", "123456")
    
To use the API you then create an instance of YahooSM::API and pass this your client object.

    api = YahooSM::API.new(client)

You can now select the service your require to use

    report_service = api.service("BasicReportService")

### Fetching a list of reports

    report_service.get_report_list
    # [<ReportInfo>]
Each report will be returned as a ReportInfo object.    
    
### Creating a new report
    
To create a new report you'll need to supply your account_id, a BasicReportRequest object and a FileOutputFormat object.

    account_id                = 98765
    
    report_request            = YahooSM::BasicReportRequest.new("Report Name", "Report Type")
    report_request.start_date = 2.days.ago
    report_request.end_date   = Time.now

FileOutputFormat takes a file type and optionally an argument for zipping the report.
    
    output                    = YahooSM::FileOutputFormat.new("CSV", true)
    
    report_id                 = report_service.add_report_request(account_id, report_request, output)
    # returns to report_id
    
### Checking the status of a report

    info = report_service.get_report_download_url(report_id)
    info.report_status # Pending, Completed etc

If the report is complete then the download_url will be available
    
## Copyright

Copyright (c) 2011 Kieran Johnson. See LICENSE for details.
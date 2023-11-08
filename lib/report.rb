require 'csv'
require './lib/transfer_querier'

class Report
    TEMP_REPORT = "./temp/transfer_ids.csv"

    def self.write_temp_report(ids)
        CSV.open(TEMP_REPORT, 'a') do |temp_report|
            ids.each do |id|
                temp_report << [id]
            end
        end
    end

    def self.write_final_report
        transfer_ids = CSV.open(TEMP_REPORT).readlines
        transfers = TransferQuerier.query(transfer_ids.flatten)

        report_data = create_report(transfers)

        final_report_file = "./temp/#{Time.now.strftime("%Y-%m-%d_%H%M%S")}.csv"
        CSV.open(final_report_file, 'w') do |report|
            report << ['Success Rate %', 'Errors list', 'Avg. transfer conclusion time in seconds']
            report << report_data
        end

        File.delete(TEMP_REPORT)
    end

    private

    def self.create_report(transfers)
        data = []
        data << calculate_success_rate(transfers)
        data << error_list(transfers)
        data << calculate_transfer_time(transfers)
        return data
    end

    def self.calculate_success_rate(transfers)
        total_transfers = transfers.size
        success_transfers = transfers.find_all{|t| t[:status] == 'success' }.count
        return "#{(success_transfers.to_f / total_transfers.to_f * 100.0).round(2)}%"
    end

    def self.error_list(transfers)
        errors = transfers.map{|t| t[:error]}.reject(&:empty?)
        return errors.flatten.uniq.join('; ')
    end

    def self.calculate_transfer_time(transfers)
        times = []
        transfers.each do |transfer|
            times << ((transfer[:updated_at] - transfer[:created_at]) * 24 * 60 * 60)
        end

        total_transfers = times.size
        return (times.sum.to_f / total_transfers.to_f).round(1)
    end
end
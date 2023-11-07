require 'starkbank'
require './lib/auth'
require './lib/report'
require './lib/transfer'

class TransferSender
    def self.send_transfers
        StarkBank.user = Auth.authenticate_user
        new_transfers = Transfer.new(10)
        transfers = StarkBank::Transfer.create(new_transfers.created_transfers)

        transfers_id = transfers.map(&:id)

        Report.write_temp_report(transfers_id)
    end
end
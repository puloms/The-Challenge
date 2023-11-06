require 'starkbank'
require './lib/auth'
require './lib/transfer'

class TransferSender
    def self.send_transfers
        StarkBank.user = Auth.authenticate_user
        new_transfers = Transfer.new(1)
        transfers = StarkBank::Transfer.create(new_transfers.created_transfers)

        transfers.each do |transfer|
            puts transfer.id
        end
    end
end
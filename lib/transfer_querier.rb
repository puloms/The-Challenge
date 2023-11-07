require './lib/auth'
require 'starkbank'

class TransferQuerier
    def self.query(ids)
        parsed_transfers = []
        StarkBank.user = Auth.authenticate_user
        transfers = StarkBank::Transfer.query(ids: ids)
        transfers.each do |transfer|
            parsed_transfers << {
                id: transfer.id,
                status: transfer.status,
                created_at: transfer.created,
                updated_at: transfer.updated,
                error: transfer.status != 'failed' ? [] : query_log_errors(transfer.id)
            }
        end
        return parsed_transfers
    end

    def self.query_log_errors(id)
        logs = StarkBank::Transfer::Log.query(transfer_ids: [id])
        error_log = logs.find{|l| l.type == 'failed'}
        return error_log.errors
    end
end
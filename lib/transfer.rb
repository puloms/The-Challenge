require 'cpf_cnpj'
require 'faker'

class Transfer
    attr_reader :created_transfers

    def initialize(number)
        @number = number
        create_transfers
    end

    def create_transfers
        @created_transfers = []
        
        @number.times do |t|
            @created_transfers << new_transfer
        end
    end

    private

    def new_transfer
        transfer = {
            amount: Random.rand(100..100000),
            bank_code: random_ISPB,
            branch_code: Faker::Bank.account_number(digits: 4),
            account_number: Faker::Bank.account_number(digits: 7),
            tax_id: CPF.generate(true),
            name: Faker::TvShows::GameOfThrones.character
    }
        return transfer
    end

    def random_ISPB
        ['90400888','60701190','60746948','30306294','18236120'].sample
    end
end
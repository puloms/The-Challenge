class Auth
    PROJECT_ID = ENV['projectId']
    PRIVATE_KEY = ENV['private_key_path'].nil? ? './keys/privateKey.pem' : ENV['private_key_path']
    STARK_ENV = 'sandbox'
 
    def self.authenticate_user
        raise 'No projectId environment variable found.' if PROJECT_ID.nil?

        private_key_content = File.read(PRIVATE_KEY)

        user = StarkBank::Project.new(
            environment: STARK_ENV,
            id: PROJECT_ID,
            private_key: private_key_content
        )
    
        return user
    end
end
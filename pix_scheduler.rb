require('debug')
require('starkbank')


def authenticated_user
    projectId = ENV['projectId']
    raise 'No projectId environment variable found.' if projectId.nil?

    private_key_content = File.read('./keys/privateKey.pem')

    user = StarkBank::Project.new(
        environment: 'sandbox',
        id: projectId,
        private_key: private_key_content
    )
    
    return user
end

StarkBank.user = authenticated_user
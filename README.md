# The Challenge
This is Stark Bank Test Engineer Trials.

# Requirements
Ruby (version higher than 3)

# Instalation
I strongly recommend RVM: https://rvm.io/

Install it in the link above the follow this [instructions](https://rvm.io/rubies/installing)

### Then

`$ bundle install`

# Setting

Create a `temp/` directory in the root of the project, you'll find the report there.

Also, create an environment variable named `projectId` with your sandbox project id.

# Authentication

By default, it'll try to find your private key at `keys/privateKey.pem` in the root of the project, but you can set an environment variable named `private_key_path` with the path to your key, consider `.` as the root of the project when writing the path.

# Changes
To change environment rather than `sandbox`, go to [here](https://github.com/puloms/The-Challenge/blob/f4cb83d9c7d99cfc15fa913dde9f316ee537fbbe/lib/auth.rb#L4C25-L4C25) and change it.

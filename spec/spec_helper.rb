require 'rspec'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require 'hac_adapter'
require 'vcr'
require 'webmock/rspec'

RSpec.configure do |c|
  c.color_mode = true
end

VCR.configure do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = './spec/cassettes'
  c.hook_into :webmock
end

def auth_params
  # This is the hash format all the #new instances require.
  # Don't commit your credentials!!!
  {
      url: 'https://hac40.esp.k12.ar.us/HomeAccess40',
      school: 'Little Rock School District',
      username: 'Test.User',
      password: 'testpassword'
  }
end

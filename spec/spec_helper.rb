require 'rspec'
require 'capybara/rspec'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'pry'
require 'site_prism'
require 'benchmark'
require 'dotenv'
require 'securerandom'

require_relative '../lib/utils/branch_app'
require_relative '../lib/utils/page_actions'
require_relative '../lib/utils/restcleint'

# load env vars, default file .env
Dotenv.load

# loading page object files
page_paths = File.join(Dir.pwd, 'lib', '**', '*.rb')
Dir.glob(page_paths).each { |file| require file }

# register chrome driver:
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :chrome
Capybara.app_host = 'https://dashboard.branch.io'
Capybara.default_max_wait_time = 15

RSpec.configure do |config|
  config.before(:each) do
    config.include Capybara::DSL
  end
end

# create instance methods using singleton:
# all page objects will be available as:
# app.<my_page>.<my_method>

def app
  BranchApp.new
end
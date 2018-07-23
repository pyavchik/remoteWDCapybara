require 'bundler/setup'
require 'ostruct'
require 'selenium-webdriver'
require 'rspec'
require 'rspec-steps'
require 'capybara/rspec'
require 'true_automation/rspec'
require 'true_automation/driver/capybara'

def camelize(str)
  str.split('_').map {|w| w.capitalize}.join
end

spec_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(spec_dir)

$data = {}
Dir[File.join(spec_dir, 'fixtures/**/*.yml')].each {|f|
  title = File.basename(f, '.yml')
  $data[title] = OpenStruct.new(YAML::load(File.open(f)))
}

$data = OpenStruct.new($data)
Dir[File.join(spec_dir, 'support/**/*.rb')].each {|f| require f}


RSpec.configure do |config|
  config.include Capybara::DSL
  config.include TrueAutomation::DSL

  case ENV['webdriver']
  when "chrome"
    Capybara.register_driver :true_automation_driver do |app|
      TrueAutomation::Driver::Capybara.new(app, browser: :remote, url: 'http://localhost:9515')
    end
  when "firefox"
    Capybara.register_driver :true_automation_driver do |app|
      TrueAutomation::Driver::Capybara.new(app, browser: :remote, url: 'http://localhost:4444')
    end
  when "safari"
    Capybara.register_driver :true_automation_driver do |app|
      TrueAutomation::Driver::Capybara.new(app, browser: :remote, url: 'http://localhost:2345')
    end
  when "ios"
    Capybara.register_driver :true_automation_driver do |app|
      caps = Selenium::WebDriver::Remote::Capabilities.new
      caps['automationName'] = 'XCUITest'
      caps['platformName'] = 'iOS'
      caps['deviceName'] = 'iPhone X (11.4)'
      caps['udid'] = '1DA711FE-C66B-4538-9147-10852CF5F1ED'
      caps['browserName'] = 'safari'
      TrueAutomation::Driver::Capybara.new(app, browser: :remote,
                                           url: 'http://localhost:4723/wd/hub',
                                           desired_capabilities: caps)
    end
  when "android"
    Capybara.register_driver :true_automation_driver do |app|
      caps = Selenium::WebDriver::Remote::Capabilities.new
      caps['platformName'] = 'Android'
      caps['browserName'] = 'chrome'
      caps['deviceName'] = 'Android'
      TrueAutomation::Driver::Capybara.new(app, browser: :remote,
                                           url: 'http://localhost:4723/wd/hub',
                                           desired_capabilities: caps)
    end
  when "edge"
    Capybara.register_driver :true_automation_driver do |app|
      TrueAutomation::Driver::Capybara.new(app, browser: :remote, url: 'http://localhost:0000')
    end
  else
    Capybara.register_driver :true_automation_driver do |app|
      TrueAutomation::Driver::Capybara.new(app, browser: :remote, url: 'http://localhost:4444')
    end
  end


  Capybara.configure do |capybara|
    capybara.run_server = false
    capybara.default_max_wait_time = 5
    capybara.default_driver = :true_automation_driver
  end


  Dir[File.join(spec_dir, 'support/**/*.rb')].each {|f|
    base = File.basename(f, '.rb')
    klass = camelize(base)
    config.include Module.const_get(klass)
  }

end



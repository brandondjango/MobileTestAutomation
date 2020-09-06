require_relative 'env.rb'

module Mobile
  class Helper

  def start_driver_from_yml(path_to_yml)
    options = YAML.load(File.read(path_to_yml))
    @driver = Appium::Driver.new(options, true)
    @driver.start_driver
  end

  def start_driver_from_hash(capabilities)
    @driver = Appium::Driver.new(capabilities, true)
    @driver.start_driver
  end

  end
end
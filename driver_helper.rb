require 'yaml'
require 'appium_lib'
require_rel 'support/driver_templates'

class DriverHelper

  def create_android_emulator(app:, avd:)
    #pull initial capabilities from template
    options = YAML.load(File.read(File.join(__dir__, "driver_templates/android_emulator.yml")))

    #populate capabilities with arguments
    options["caps"]["app"] = app
    options["caps"]["avd"] = avd

    #create and start driver
    driver = Appium::Driver.new(options, true)
    driver.start_driver

    #return Appium driver
    return driver
  end

  def create_android_real_device(app:, deviceName:)
    #pull initial capabilities from template
    options = YAML.load(File.read(File.join(__dir__,"lib/driver_templates/android_real_device.yml")))

    #populate capabilities with arguments
    options["caps"]["app"] = app
    options["caps"]["deviceName"] = deviceName

    #create and start driver
    driver = Appium::Driver.new(options, true)
    driver.start_driver

    #return Appium driver
    return driver
  end

  def create_ios_simulator(app:, platformVersion:, deviceName:)
    #pull initial capabilities from template
    options = YAML.load(File.read(File.join(__dir__, "lib/driver_templates/ios_simulator.yml")))

    #populate capabilities with arguments
    options["caps"]["app"] = app
    options["caps"]["platformVersion"] = platformVersion
    options["caps"]["deviceName"] = deviceName

    #create and start driver
    driver = Appium::Driver.new(options, true)
    driver.start_driver

    #return Appium driver
    return driver
  end

  def create_ios_real_device(app:, platformVersion:, udid:)
    #pull initial capabilities from template
    options = YAML.load(File.read(File.join(__dir__, "lib/driver_templates/ios_simulator.yml")))

    #populate capabilities with arguments
    options["caps"]["app"] = app
    options["caps"]["platformVersion"] = platformVersion
    options["caps"]["udid"] = udid

    #create and start driver
    driver = Appium::Driver.new(options, true)
    driver.start_driver

    #return Appium driver
    return driver
  end


end

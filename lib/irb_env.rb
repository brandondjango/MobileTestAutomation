require 'require_all'
require 'yaml'
require 'appium_lib'

#require BasePage and DriverHelper
require_rel './'

def create_iphonex_safari_driver
    helper = DriverHelper.new
    helper.create_ios_simulator_safari(browserName: "Safari", platformVersion: "13.5", deviceName: "iPhone X")
end

def create_pixel_chrome_driver
    helper = DriverHelper.new
    helper.create_android_chrome_emulator(browserName: "chrome", avd: "Pixel3")
end
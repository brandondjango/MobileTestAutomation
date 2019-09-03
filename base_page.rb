require 'require_all'
require 'selenium-webdriver'
require 'page-object'
require 'watir-scroll'
require 'yaml'


class BasePage

    include PageObject

    def initialize(driver)
      @driver = driver
    end

    def find_element(*args)
      #Initialize retry count
      attempts = 0
      success = false

      #retry logic
      while success == false && attempts < 20
        begin
          return @driver.find_element(*args)
        rescue Exception => e
          stabilize
          success = false
          attempts = attempts + 1
        end
      end
      return @driver.find_element(*args)

      rescue Selenium::WebDriver::Error::NoSuchElementError => e
        return nil
      end

    def find_elements(*args)
      @driver.find_elements(*args)
    end

    def element_present?(element_or_name)
      if element_or_name.nil?
        return false
      end
      element = element_for(element_or_name)
      element.displayed?
    end

    def click_element(element_or_name)
      element = element_for(element_or_name)
      element.click
    end

    def click_with_error_handling(element_or_name)
      success = false
      attempts = 0
      while success.equal?(false ) && attempts < 15
        begin
          click_element(element_or_name)
       rescue Exception => e
         success = false
         attempts = attempts + 1
         stabilize
        end
      end
    end

    def set_field(element_name, value)
      element = element_for(element_name)
      clear_element(element_name)
      element.send_keys(value)
    end

    def send_enter(element_name)
      element = element_for(element_name)
      element.send_keys(Keys.ENTER)
    end

    def clear_element(element_or_name)
      wait_for_element(element_or_name)
      element = element_for(element_or_name)
      element.clear

      #for androids
      hide_device_keyboard unless ios_device?
    end

    def ios_device?
      @driver.device_is_ios?
    end

    def android_device?
      @driver.device_is_android?
    end

    def wait_for_element(element, timeout: nil)
      timeout ||= 10
      wait_until(timeout: timeout) do
        element_present?(element)
      end
    end

    def wait_for_element_gone(element_or_name, timeout: nil)
      timeout ||= 5
      element = element_for(element_or_name)
      wait_until(timeout: timeout) do
        !element_present?(element)
      end
    end

    def long_press_element(element_or_name)
      element = element_for(element_or_name)
      @driver.touch_action.long_press(element).perform
    end

    def resolve_element(element_or_name, plural)
      # Could have been given the name of an element or an element object
      if element_or_name.is_a?(String) || element_or_name.is_a?(Symbol)
        send("#{element_or_name}#{plural ? 's' : ''}")
      else
        element_or_name
      end
    end

    def element_for(element_or_name, plural = false)
      begin
        element = resolve_element(element_or_name, plural)
      rescue NoMethodError => e
        raise e
      end
      raise(ArgumentError, "No element returned for '#{element_or_name}'") unless element
      element
    end

    def remove_fiction_app
      @driver.remove_app('org.oclc.fiction500')
    end

    def stabilize
      sleep(0.25)
    end

    def hide_device_keyboard
      @driver.hide_keyboard unless !@driver.is_keyboard_shown
    end

    def scroll_element(element)
      @driver.touch_action.scroll(element, 10, 100).perform
    end

end

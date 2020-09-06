require_relative 'env.rb'

module Mobile
  class BasePage


    include PageObject

    def initialize(driver)
      @driver = driver
    end

    def get_current_context
      @driver.current_context
    end

    def get_available_contexts
      @driver.available_contexts
    end

    def set_current_context(context)
      @driver.set_context(context)
    end

    #switches to first webview context that is not your current context
    def switch_webview_contexts
      available_contexts = get_available_contexts
      current_context = get_current_context

      correct_context = (available_contexts.select do |context|
        context.downcase.include?("webview") && !context.include?(current_context)
      end).first

      set_current_context(correct_context)
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

      #if you reach this point, your error will be out put after your 20 retries
      begin
        return @driver.find_element(*args)
      rescue Exception => e
        print "find_element failed after " + attempts.to_s + " attempts because of error: " + e.to_s
        print "\nReturning nil"
        return nil
      end
    end

    def find_elements(*args)
      @driver.find_elements(*args)
    end

    def element_present?(element)
      if element.nil?
        return false
      end
      element.displayed?
    end

    def click_element(element)
      element.click
    end

    def click_with_error_handling(element)
      success = false
      attempts = 0
      while success.equal?(false ) && attempts < 16
        begin
          click_element(element)
        rescue Exception => e
          if attempts == 15
            raise e
          end
         success = false
         attempts = attempts + 1
         stabilize
        end
      end
    end

    def set_field(element, value)
      clear_element(element)
      element.send_keys(value)
    end

    def send_enter(element)
      element.send_keys(Keys.ENTER)
    end

    def clear_element(element)
      wait_for_element(element)
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
      WaitUtil.wait_for_condition(element_present?(element), :timeout_sec => timeout, :delay_sec => 0.5)
    end

    def wait_for_element_gone(element, timeout: nil)
      timeout ||= 5
      WaitUtil.wait_for_condition(!element_present?(element), :timeout_sec => timeout, :delay_sec => 0.5)
    end

    def long_press_element(element)
      @driver.touch_action.long_press(element).perform
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
end

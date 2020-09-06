Gem::Specification.new do |s|
  s.name = %q{mobile_support}
  s.version = "0.0.0"
  s.date = %q{2020-09-06}
  s.summary = %q{This gem is a support for mobile automation using appium}
  s.authors       = ["Lockridge"]
  s.email         = ["brandonlockridge@gmail.com"]
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'appium_lib'
  s.add_runtime_dependency 'page-object'
  s.add_runtime_dependency 'selenium-webdriver'
  s.add_runtime_dependency 'waitutil'
  s.add_runtime_dependency 'require_all'
  s.add_runtime_dependency 'rake'
end
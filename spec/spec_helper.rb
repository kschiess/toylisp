require 'spec'

$:.unshift File.join(File.dirname(__FILE__) + "/../lib")
require 'lisp'

Spec::Runner.configure do |config|
  config.mock_with :flexmock
end
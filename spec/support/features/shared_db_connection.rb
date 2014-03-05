# This is not true Strategy for js testing.
# Please use database-cleaner gem.
# source http://blog.plataformatec.com.br/2011/12/three-tips-to-improve-the-performance-of-your-test-suite/
#class ActiveRecord::Base
#  mattr_accessor :shared_connection
#  @@shared_connection = nil
#
#  def self.connection
#    @@shared_connection || retrieve_connection
#  end
#end
#
## Forces all threads to share the same connection. This works on
## Capybara because it starts the web server in a thread.
#ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
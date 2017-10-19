require './app/controllers/emails_controller'
require './app/controllers/errors_controller'
require './app/controllers/pages_controller'
require './app/models/email'

module EmailCollector
  DATABASE = './db/email_addresses.txt'.freeze

  class Application
    def self.call(env)
      req = Rack::Request.new(env)
      return PagesController.root             if req.get?  && req.path == '/'
      # YOUR CODE HERE
      ErrorsController.not_found
    end
  end
end

class ApplicationController < ActionController::Base
  include ApplicationHelper
  include AuthHelper
  include ErrorHandling
  include Authentication
end

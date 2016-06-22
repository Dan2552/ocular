require_relative './node_modules/jquery/dist/jquery'
require 'opal-jquery'
require_tree './view_controller'

require 'console'
require 'native'

APP_STATE_HANDLER = UIEventHandler.new

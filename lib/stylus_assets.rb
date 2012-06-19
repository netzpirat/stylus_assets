# coding: UTF-8

require 'pathname'

require 'tilt'
require 'sprockets'

require 'stylus_assets/version'
require 'stylus_assets/stylus_template'

if defined?(Rails)
  require 'rails'
  require 'stylus_assets/engine'
else
  require 'sprockets'
  require 'sprockets/engines'
  Sprockets.register_engine '.stylt', StylusAssets::StylusTemplate
end

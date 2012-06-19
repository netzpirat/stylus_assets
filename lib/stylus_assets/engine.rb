# coding: UTF-8

module StylusAssets

  # Hook the less template into a Rails app.
  #
  class Engine < Rails::Engine

    config.stylus_assets = ActiveSupport::OrderedOptions.new

    # Initialize Haml Coffee Assets after Sprockets
    #
    initializer 'sprockets.stylusassets', :group => :all, :after => 'sprockets.environment' do |app|
      next unless app.assets

      # Register tilt template
      app.assets.register_engine '.stylt', StylusTemplate
    end

  end
end

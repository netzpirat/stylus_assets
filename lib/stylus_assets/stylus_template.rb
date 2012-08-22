# coding: UTF-8

require 'tilt'

module StylusAssets

  # Stylus template implementation for Tilt.
  #
  class StylusTemplate < Tilt::Template

    class << self
      # A proc that is called to modify the template name used as the
      # JST key. The proc is passed the name as an argument and should
      # return the modified name (or unmodified) name.
      attr_accessor :name_filter

      # The JavaScript Style template namespace
      attr_accessor :namespace

      # The variable prefix
      attr_accessor :variable_prefix
    end

    # By default the namespace is JSST (JavaScript Style template)
    self.namespace = 'window.JSST'

    # By default, remove any leading `templates/`, `styles/` and `stylesheets/` in the name
    self.name_filter = lambda { |n| n.sub /^(templates|styles|stylesheets)\//, '' }

    # The default mime type of the tilt template
    self.default_mime_type = 'application/javascript'

    # If the variable should be prefixed with a $ sign
    self.variable_prefix = false
    
    # Test if the compiler is initialized.
    #
    # @return [Boolean] the initialization status
    #
    def self.engine_initialized?
      true
    end

    # Initialize the template engine.
    #
    def initialize_engine
    end

    # Prepare the template
    #
    def prepare
    end

    # Generates the Stylus template wrapped in a JavaScript template
    #
    # @param [String] name the template name
    # @return [String] the less JavaScript template
    #
    def evaluate(scope, locals = { }, &block)
      name = scope.logical_path
      name = self.class.name_filter.call(name) if self.class.name_filter

      <<-JST
(function() {
  #{ self.class.namespace } || (#{ self.class.namespace } = {});
  #{ self.class.namespace }['#{ name }'] = function(v, e, i) { return StylusAssets.render('#{ name }', \"#{ data.gsub(/\n/, "\\n") }\", v, e, i); };
}).call(this);
      JST
    end

  end
end


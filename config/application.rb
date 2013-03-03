require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module BootstrapRspecLibioCloneApp
  class Application < Rails::Application
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.active_record.whitelist_attributes = true
    config.assets.enabled = true
    config.assets.version = '1.0'
  end
end

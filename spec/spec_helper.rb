ENV["RAILS_ENV"] = "test"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'asset_pipeline_routes'
require 'rspec'
require 'ostruct'
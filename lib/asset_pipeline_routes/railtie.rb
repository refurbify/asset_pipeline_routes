# encoding: UTF-8
module AssetPipelineRoutes
  class Railtie < ::Rails::Railtie
    if config.respond_to?(:assets) and not config.assets.nil?
      config.assets.configure do |env|
        env.register_preprocessor('application/javascript', PathProcessor)
      end
    end
  end
end

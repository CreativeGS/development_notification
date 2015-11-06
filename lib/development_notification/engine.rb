module DevelopmentNotification
  class Engine < ::Rails::Engine
    isolate_namespace DevelopmentNotification

    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end

    initializer :append_migrations do |app|
      unless app.root.to_s == root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

  end
end

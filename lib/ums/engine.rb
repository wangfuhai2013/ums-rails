module Ums
  class Engine < ::Rails::Engine
    isolate_namespace Ums
    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/*.rb").each do |c|
        require_dependency(c)
      end
    end
  end
end

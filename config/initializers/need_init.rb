$redis = Redis.new(:host => 'localhost', :port => 6379)

APP_CONFIG = YAML.load_file(File.join(Rails.root, "config", "settings.yml"))
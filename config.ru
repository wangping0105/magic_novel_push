# Load path and gems/bundler
$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

$:.push File.dirname(__FILE__)

require 'app'
require 'faye'
Faye::WebSocket.load_adapter('thin')

options = {
  mount: '/faye',
  timeout: 25
}

if defined?(REDIS_CONFIG)
  options.merge!(
    engine: {
      type: Faye::Redis
    }
  )

  options[:engine].merge!(REDIS_CONFIG.symbolize_keys)
end

# setup faye as rack
ikcrm_push = Faye::RackAdapter.new(options)
# ikcrm_push.add_extension(ServerAuth.new)

run ikcrm_push

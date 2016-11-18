class ServerAuth
  cattr_accessor :auth_token

  self.auth_token ||= "111111"#App.find_by(app_name: "crm_push").try(:access_token)

  def incoming(message, callback)
    if message['channel'] !~ %r{^/meta/}
      # Get subscribed channel and auth token
      subscription = message['subscription']
      token    = message['data'] && message['data']['auth_token']
      user_id    = message['data'] && message['data']['user_id']
      client_id = message['data'] && message['data']['client_id']

      unless token and token.eql? self.auth_token
        message['error'] = 'Invalid auth token'
      end
    end
    callback.call(message)
  end
  # IMPORTANT: clear out the auth token so it is not leaked to the client
  def outgoing(message, callback)
    message['data'].delete('auth_token') if message['data'].is_a?(Hash)

    if message['ext'] && message['ext']['auth_token']
      message['ext'] = {}
    end
    callback.call(message)
  end
end

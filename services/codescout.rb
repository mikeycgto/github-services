class Service::CodeScout < Service
  default_events :push, :pull_request, :public, :member

  string :token

  def receive_event
    #http.ssl[:verify] = false
    http.url_prefix = 'https://codescout.herokuapp.com/'

    http.headers['X-Token'] = token
    http.headers['X-GitHub-Event'] = event.to_s
    http.headers['Content-Type'] = 'application/json'

    http_post 'repos/receive', payload.to_json
  end

  def token
    data['token'].to_s.strip
  end
end

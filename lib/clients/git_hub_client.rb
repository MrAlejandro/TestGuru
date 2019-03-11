class GitHubClient

  ROOT_END_POINT = 'https://api.github.com'
  ACCESS_TOKEN = ENV['GITHUB_OAUTH_TOKEN']

  def initialize
    @http_client = setup_http_client
  end

  def create_gist(params)
    response = @http_client.post('/gists') do |request|
      request.headers['Authorization'] = "token #{ACCESS_TOKEN}"
      request.headers['Content-Type'] = "application/json"
      request.body = params.to_json
    end

    result(response)
  end

  private

  def result(response)
    if response.success?
      body = JSON.parse(response.body)
      { success: true, url: body["html_url"] }
    else
      { success: false }
    end
  end

  def setup_http_client
    Faraday.new(url: ROOT_END_POINT)
  end
end

class GitHubOctokitClient

  ACCESS_TOKEN = ENV['GITHUB_OAUTH_TOKEN']

  def initialize(token: nil)
    @client = setup_http_client(token || ACCESS_TOKEN)
  end

  def create_gist(options)
    result = @client.create_gist(options)
    { success: true, url: result[:html_url] }
  rescue
    { success: false }
  end

  private

  def setup_http_client(token)
    @client = Octokit::Client.new(:access_token => token)
  end
end

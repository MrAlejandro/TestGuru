class GistQuestionService

  def initialize(question)
    @question = question
    @test = @question.test
    @client = Octokit::Client.new(access_token: ENV['GITHUB_OAUTH_TOKEN'])
  end

  def call
    result = @client.create_gist(gist_params)
    { success: true, url: result[:html_url] }
  rescue
    { success: false }
  end

  private

  def gist_params
    {
        description: I18n.t("services.gist_question.gist.description", title: @test.title),
        files: {
            I18n.t("services.gist_question.gist.file_name") => {
                content: gist_content
            }
        }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end

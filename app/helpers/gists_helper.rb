module GistsHelper
  QUESTION_TRUNCATE_LENGTH = 25

  def gist_question_url(gist)
    question = gist.question
    question_beginning = truncate_question(question)
    link_to question_beginning, admin_question_path(question), target: "_blank"
  end

  def gist_url(gist)
    hash = gist_hash(gist)
    link_to hash, gist.url, target: "_blank"
  end

  private

  def gist_hash(gist)
    gist.url.split("/").last
  end

  def truncate_question(question)
    question_beginning = question.body[0...QUESTION_TRUNCATE_LENGTH]
    question_beginning << '...' if question.body.length > QUESTION_TRUNCATE_LENGTH
    question_beginning
  end
end

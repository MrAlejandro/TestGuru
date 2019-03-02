module ApplicationHelper
  def current_year
    Time.current.year
  end

  def github_url(author, repo)
    link_to("#{author} (#{repo})", "https://github.com/#{author}/#{repo}", target: :blank)
  end

  def flesh_alert(flash)
    content_tag :p, flash[:alert], class: "flash alert" if flash[:alert]
  end
end

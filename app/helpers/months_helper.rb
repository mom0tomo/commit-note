module MonthsHelper
  def avarage_commits_number(user, month_id)
    commits = user.commits.find_by(month_id: month_id)
    commits.nil? ? 0 : commits.number
  end

  def avarage_repositories_number(user, month_id)
    repositories = user.repositories.find_by(month_id: month_id)
    repositories.nil? ? 0 : repositories.number
  end
end

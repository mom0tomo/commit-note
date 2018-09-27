module MonthsHelper
  def avarage_commits_number(user, month_id)
    commits = user.commits.where(month_id: month_id)
    num = 0

    commits.each do |commit|
       num += commit.number
    end

    if commits.nil?
      num = 0
    end

    # FIXME: 閏月など全く考慮していない
    days = 30
    num / days
  end

  def avarage_repositories_number(user, month_id)
    repositories = user.repositories.find_by(month_id: month_id)
    repositories.nil? ? 0 : repositories.number
  end

  def monthly_commits(user_id, month_id)
    Commit.where(user_id: user_id, month_id: month_id)
  end
end

class CommitsController < ApplicationController
  require 'open-uri'

  def create
    @user = User.find(params[:user_id])

    # if Time.zone.now.beginning_of_day <= current_user.latest_sign_in_at && current_user.latest_sign_in_at <= Time.zone.now.end_of_day
    #   # 2度目以降のログインならそのままリダイレクトする
    #   redirect_to user_months_path(@user)
    # else
      # 今日最初のログインだったらスクレイピングとインポートを実行する
      todays_commits = Commit.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)

      delete_data
      feed = fetch_feed
      create_data!(feed)

      unless todays_commits.nil?
        flash[:success] = 'commitのデータインポート終了'
        redirect_to user_months_path(@user)
      else
        flash[:success] = 'commitのデータインポートに失敗しました。'
        render :new
      end
    # end
  end

  private

  def fetch_feed
    user = User.find(params[:user_id])
    uid = user.uid

    url = 'https://github.com/' + uid
    doc = Nokogiri::HTML open url

    commits = []
    dates = []
    doc.xpath('//rect[@class = "day"]').each do |node|
      commits += [node.attribute('data-count').value]
      dates += [node.attribute('data-date').value]
    end

    [commits, dates]
  end

  def create_data!(feed)
    commits = feed.first
    dates = feed.second

    results = []
    dates.each do |date|
      data = date.split("-", 0)

      year = data.first
      month = data.second.sub(/^0/,'')
      day = data.last

      results += [{year: year, day: day, month_id: month}]

      results.each_with_index do |result, i|
        result[:commit] = commits[i]
      end
    end

    results.each do |result|
      Commit.create!(
          number: result[:commit],
          year: result[:year],
          month_id: result[:month_id],
          day: result[:day],
          user_id: @user.id
      )
    end
  end

  def delete_data
    @user = current_user
    Commit.where(user_id: @user.id).delete_all unless nil?
  end
end

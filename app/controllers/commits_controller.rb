class CommitsController < ApplicationController
  require 'octokit'
  require 'open-uri'

  def new
    @user = User.find(params[:user_id])
  end

  def create
    todays_commits = Commit.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @user = User.find(params[:user_id])
    @month = Month.find(1)

    delete
    feed = fetch_feed
    create_data!(feed)


    unless todays_commits.nil?
      flash[:success] = 'commitのデータインポート終了'
      redirect_to user_months_path(@user)
    else
      flash[:success] = 'commitのデータインポートに失敗しました。'
      render :new
    end
  end

  private

  def fetch_feed
    client = Octokit::Client.new access_token: ''
    user = client.user

    url = 'https://github.com/' + user.login
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

    # results = [{:year=>"2017", month_id: "9",  :day=>"21", :commit=>1}, {:year=>"2018", month_id: "10", :day=>"11"}]
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

  def delete
    # FIXME: 当日より前のデータを削除する
    # Commit.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)

    # データを全て削除
    Commit.all.destroy_all
  end
end
require_relative '../lib/slack_message'
include Clockwork

configure do |config|
  config[:tz] = 'Asia/Tokyo'
end

# 毎日夜19:00に実行
every(1.day, 'nippo', at: '19:00') do
  today = Time.now.wday
  Nippo.new.run unless today == 6 || today == 0
end

# 20分に1回実行（動作確認＋Herokuアプリを眠らせないために）
every(20.minutes, 'test') do
  Test.new.run
end

require 'time'
require 'dotenv'
require 'slack-ruby-client'

# 時間を日本時間に設定
ENV['TZ'] = 'Asia/Tokyo'

Dotenv.load

Slack.configure do |conf|
  conf.token = ENV['SLACK_BOT_TOKEN']
end

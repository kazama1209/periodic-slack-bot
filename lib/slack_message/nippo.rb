require 'dotenv'
Dotenv.load

class Nippo
  def run
    slack_user_id = ENV['SLACK_USER_ID']
    nippo_url = ENV['NIPPO_URL']
    channel_name = ENV['SLACK_CHANNEL_NIPPO']

    client = Slack::Web::Client.new
    client.chat_postMessage(channel: channel_name, text: "<@#{slack_user_id}> 日報を書く時間ですよ〜\n#{nippo_url}", as_user: true)
  end
end

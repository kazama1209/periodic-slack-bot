require 'dotenv'
Dotenv.load

class Test
  def run
    client = Slack::Web::Client.new
    channel_name = ENV['SLACK_CHANNEL_TEST']

    client.chat_postMessage(channel: channel_name, text: '送信テスト', as_user: true)
  end
end
  
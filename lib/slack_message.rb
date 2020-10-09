# 初期化ファイルを読み込む
require_relative './slack_message/initialize'

# 全ファイルを読み込む
Dir[File.dirname(__FILE__) + '/slack_message/**/*.rb'].each {|f| require f }

require 'slack-ruby-client'
require 'faraday'
require 'pry-byebug'
require 'nokogiri'

def lambda_handler(event:, context:)
  slack_notification
end

def slack_notification
  client = Slack::Web::Client.new(token: ENV['SLACK_TOKEN'])
  client.chat_postMessage(channel: ENV['SLACK_CHANNEL'], text: 'hello, AWS Lambda!', as_user: true)
end

# Qiitaからトレンド記事を取得する
def fetch_trend_from_qiita
  response = Faraday.get('https://qiita.com/')
  doc = Nokogiri::HTML(response.body)
  doc.css('.tr-Item_title')[0..10].map { |a| a[:href] }
end

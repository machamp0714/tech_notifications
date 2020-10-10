require 'slack-ruby-client'
require 'faraday'
require 'nokogiri'

def lambda_handler(event:, context:)
  urls = fetch_trend_from_qiita
  text = <<~TEXT
    #{urls.join("\n")}
  TEXT
  slack_notification(text)
end

def slack_notification(text)
  client = Slack::Web::Client.new(token: ENV['SLACK_TOKEN'])
  client.chat_postMessage(channel: ENV['SLACK_CHANNEL'], text: text, as_user: true)
end

# Qiitaからトレンド記事を取得する
def fetch_trend_from_qiita
  response = Faraday.get('https://qiita.com/')
  doc = Nokogiri::HTML(response.body)
  doc.css('.tr-Item_title')[0..10].map { |a| a[:href] }
end

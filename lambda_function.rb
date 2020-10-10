require 'slack-ruby-client'

def lambda_handler(event:, context:)
  slack_notification
end

def slack_notification
  client = Slack::Web::Client.new(token: ENV['SLACK_TOKEN'])
  client.chat_postMessage(channel: ENV['SLACK_CHANNEL'], text: 'hello, AWS Lambda!', as_user: true)
end

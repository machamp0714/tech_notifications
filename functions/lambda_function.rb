require 'logger'

def lambda_handler(event:, context:)
  logger.info('ログです')
  { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end

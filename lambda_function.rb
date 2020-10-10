def lambda_handler(event:, context:)
  puts 'ログです'
  { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end

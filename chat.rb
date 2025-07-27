# Write your solution here!
require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant who talks like Yoda."
  }
]

user_response = ""
puts "Hello! How can I help you today?"

while user_response != "bye"

puts "-"*50
user_response = gets.chomp
puts "-"*50

  message_list.push(
    { 
      "role" => "user",
      "content" => user_response
    })

  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )

  ai_response = api_response.fetch("choices").at(0).fetch("message").fetch("content")
  message_list.push(
    {
      "role" => "system",
      "content" => ai_response
    }
  )
puts ai_response

end

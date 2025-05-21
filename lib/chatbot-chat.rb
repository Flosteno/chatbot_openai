require 'http'
require 'dotenv'
require 'json'


Dotenv.load

api_key = ENV["OPENAI_API_KEY"]

def response_openai(prompt)

  api_key = ENV["OPENAI_API_KEY"]
  url = "https://api.openai.com/v1/completions"

  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{api_key}"
  }


  data = {
    "prompt" =>  prompt,
    "max_tokens" => 150,
    "temperature" => 0,
    "n" => 1,
    "model" => "gpt-3.5-turbo-instruct"
  }

  response = HTTP.post(url, headers: headers, body: data.to_json)
  response_body = JSON.parse(response.body.to_s)
  response_string = response_body['choices'][0]['text'].strip

return response_string

end




conversation_history = ""

def converse_with_ai(conversation_history)


  loop do

    print "Vous : "
    prompt = gets.chomp

    if prompt != "stop"

      conversation_history += "\nVous : #{prompt}"
      response = response_openai(conversation_history)
      puts "AI : #{response}"

      conversation_history += "\nAI : #{response}"
    end
    
  break if prompt == "stop"

  # puts "test : #{conversation_history}"

  end
end

converse_with_ai(conversation_history)
require 'http'
require 'dotenv'
require 'json'


Dotenv.load


def login_openai

    api_key =ENV["OPENAI_API_KEY"]
  url = "https://api.openai.com/v1/models"
  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{api_key}"
  }

  response = HTTP.get(url, headers: headers)
  puts response

end



api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/completions"


headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

# trouve 5 parfums de glace aléatoires et affiche les en ligne
data = {
  "prompt" => "Liste 5 ingrédients d'une recette: \n- farine ",
  "max_tokens" => 150,
  "temperature" => 0,
  "model" => "babbage-002"
}

# login_openai


response = HTTP.post(url, headers: headers, body: data.to_json)
response_body = JSON.parse(response.body.to_s)
response_string = response_body['choices'][0]['text'].strip


puts "Voici 1 recette de cuisine aléatoire :"
puts response_string
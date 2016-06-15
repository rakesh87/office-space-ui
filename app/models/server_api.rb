require "rest-client"

class ServerApi
  def initialize(api_url="http://localhost:3000")
    @api_key = ENV["api_key"]
    @api_url = ENV["api_url"] || api_url
  end

  attr_reader :api_key, :api_url

  def office_spaces
    parse_server_data_tojson(RestClient.get("#{api_url}/api/v1"))
  end

  def login(email:, password:)
    parse_server_data_tojson(RestClient.post("#{api_url}/api/v1/sign_in", {email: email, password: password}))
  rescue RestClient::UnprocessableEntity => e
    {"errors" => true, "message" => e.message}
  end

  def register(email:, password:, password_confirmation:)
    parse_server_data_tojson(RestClient.post("#{api_url}/api/v1/sign_up", {"user" => { email: email, password: password, password_confirmation: password_confirmation } }))
  rescue RestClient::UnprocessableEntity => e
    {"errors" => true, "message" => e.message}
  end

  def parse_server_data_tojson(server_response)
    JSON.parse(server_response)
  end

  def get_user(id:)
    parse_server_data_tojson(RestClient.post("#{api_url}/api/v1/get_user", { id: id } ))
  rescue RestClient::ResourceNotFound => e
    {"errors" => true, "message" => e.message}
  end
end
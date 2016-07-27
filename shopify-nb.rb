require 'nationbuilder'
require 'rest-client'
require 'json'
require 'pry'

NATIONBUILDER_AUTH_TOKEN =  {NATIONBUILDER_SUBDOMAIN}
NATIONBUILDER_SUBDOMAIN =  {NATIONBUILDER_AUTH_TOKEN}


PERSON_UPDATE = {
  person: {
    email: "malachi@madebypumpkin.com"
  }
}

def update(id)
  url = "https://#{NATIONBUILDER_SUBDOMAIN}.nationbuilder.com/api/v1/people/push?access_token=#{NATIONBUILDER_AUTH_TOKEN}"
  RestClient.put url, PERSON_UPDATE.to_json, {content_type: :json, accept: :json} do |response, request, result|
    case response.code
    when 200
      puts "Person #{id} updated!"
      person = JSON.parse(response.body)
      puts person.to_s
      destroy(person["person"]["id"])
    else
      puts "Update request failed! #{response.code}"
    end
  end
end


update

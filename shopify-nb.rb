## NationBuilder Developer Certification
## People
## - Create a person
## - Update the person
## - Delete the person

require 'nationbuilder'
require 'rest-client'
require 'json'
require 'pry'

NATIONBUILDER_AUTH_TOKEN =  '08e6af548df42ea1262d7b9eb2b965801276d2fa622fd26ac4c50ae30e9bf077'
NATIONBUILDER_SUBDOMAIN =  'teddyforprez'

PERSON_CREATE = {
  person: {
    email: "ben.wientge@gmail.com",
    first_name: "Ben",
    last_name: "Wientge",
    sex: "M",
    signup_type: 0,
    employer: "Made by Pumpkin",
    party: "P",
    registered_address: {
      state: "CA",
      country_code: "US"
    }
  }
}


PERSON_UPDATE = {
  person: {
    email: "malachi@madebypumpkin.com"
  }
}

def create
  url = "https://teddyforprez.nationbuilder.com/api/v1/people?access_token=08e6af548df42ea1262d7b9eb2b965801276d2fa622fd26ac4c50ae30e9bf077"
  RestClient.post url, PERSON_CREATE.to_json, {content_type: :json, accept: :json} do |response, request, result|
    case response.code
    when 201
      puts "Person created!"
      person = JSON.parse(response.body)
      puts person.to_s
      update(person["person"]["id"])
    else
      puts "Create request failed! #{response.code}"
    end
  end
end

def update(id)
  url = "https://teddyforprez.nationbuilder.com/api/v1/people/1422296?access_token=08e6af548df42ea1262d7b9eb2b965801276d2fa622fd26ac4c50ae30e9bf077"
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

def destroy(id)
  url = "https://#{NATIONBUILDER_SUBDOMAIN}.nationbuilder.com/api/v1/people/#{id}?access_token=#{NATIONBUILDER_AUTH_TOKEN}"
  RestClient.delete url, {accept: :json} do |response, request, result|
    case response.code
    when 204
      puts "Person #{id} deleted!"
    else
      puts "Delete request failed! #{response.code}"
    end
  end
end

create
# update(id = 1422296)
# destroy(id = 1422296)

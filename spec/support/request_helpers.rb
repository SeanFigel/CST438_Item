# Includes methods to make HTTP request spec test easier
module RequestHelpers
    def response_json
        JSON.parse(response.body)
    end
end
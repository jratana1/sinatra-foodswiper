class Helpers
    def self.current_user(session)
        User.find(session[:user_id])
    end

    def self.is_logged_in?(session)
        !!session[:user_id]
    end

    def self.yelp_hash_converter(hash)
        @rest_hash = {}
        @rest_hash[:name] = hash["name"]
        @rest_hash[:display_phone] = hash["display_phone"]
        @rest_hash[:rating] = hash["rating"]
        @rest_hash[:url] = hash["url"]
        @rest_hash[:address] = hash["location"]["address1"]
        @rest_hash[:city] = hash["location"]["city"]
        @rest_hash[:state] = hash["location"]["state"]
        @rest_hash[:zip_code] = hash["location"]["zip_code"]
        @rest_hash[:yelp_id] = hash["id"]
        @rest_hash[:image_url] = hash["image_url"]
        @rest_hash
    end

    def self.slug_string(string)
        slug = string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
end
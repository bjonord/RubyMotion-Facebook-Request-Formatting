# Formatting for the facebook entries used by locations and constant with permissions.
# 
# app/lib/facebook_model_extras.rb
# Author: Bjorn Skarner
# Date: 2012-08-25
#
# ####
module FacebookExtras
  PERMISSIONS = ["user_location", "read_stream", "friends_status", "friends_checkins", "friends_location", "read_friendlists"]

  class FacebookEntryFormatter

    def initialize(entry)
      @entry = entry
    end

    def format_entry_from_facebook
      formatted_data = get_first_level_information.merge(get_user_information).merge(get_place_information)
    end

    def get_first_level_information
      values = first_level_values
      data = {}

      values.each do |key, value|
        data[key] = @entry[value]
      end
      data
    end

    def get_user_information
      values = user_values
      data = {}

      values.each do |key, value|
        data[key] = @entry["from"][value]
      end
      data
    end

    def get_place_information
      values = place_values
      data_name = {}

      values.each do |key, value|
        data_name[key] = @entry["place"][value]
      end

      values = location_values
      data_location = {}

       values.each do |key, value|
        data_location[key] = @entry["place"]["location"][value]
      end
      data = data_name.merge(data_location)
    end

    private 
      def first_level_values
        {        
          post_id:    "id", 
          message:    "message", 
          caption:    "caption", 
          story:      "story", 
          picture:    "picture", 
          link:       "link", 
          type:       "type", 
          created_at: "created_time"
        }
      end

      def user_values
        {        
          name:       "name",
          user_id:    "id"
        }
      end

      def place_values
        {        
          place_name: "name"
        }
      end

      def location_values
        {
          street:     "street", 
          city:       "city", 
          latitude:   "latitude", 
          longitude:  "longitude", 
          country:    "country"
        }
      end
  end
end
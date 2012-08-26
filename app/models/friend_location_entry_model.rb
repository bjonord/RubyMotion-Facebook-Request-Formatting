# This class is used for the storage of every location entry in the data set.
#
# app/models/friend_lovation_entry_model.rb
# Author: Bjorn Skarner
# Date: 2012-08-06
#
#
#

class FriendLocationEntryModel
  ###
  # All the properties needed for the entries are set here. 
  # The properties that could be varying between accounts will be id and type. 
  # Facebook digit ID, Twitter digit ID
  # TODO: Account types will be "Facebook", "Twitter", ... more coming. 
  # NOTE: Should this be split into to two models? Might be better for future development. Have a think about it.
  ###
  PROPERTIES = [:post_id, :account_type, :name, :user_id, :message, :caption, :story, :picture, :link, :type, :place_name, :street, :city, :latitude, :longitude, :country, :created_at]

  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize(attributes = {})
    attributes.each { |key, value|
      self.send("#{key}=", value) if PROPERTIES.member? key
    }
  end

  def initWithCoder(decoder)
    self.init
    PROPERTIES.each { |prop|
      value = decoder.decodeObjectForKey(prop.to_s)
      self.send((prop.to_s + "=").to_s, value) if value
    }
    self
  end

  # called when saving an object to NSUserDefaults
  def encodeWithCoder(encoder)
    PROPERTIES.each { |prop|
      encoder.encodeObject(self.send(prop), forKey: prop.to_s)
    }
  end
end
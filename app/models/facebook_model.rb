# The model used to setup and retrieve Facebook data. This is a singleton class, to ensure safe request handling.
# 
# app/models/facebook_model.rb
# Author: Bjorn Skarner
# Date: 2012-08-06
#
# ####

class FacebookModel
  attr_accessor :facebook
  attr_reader   :since
  attr_reader   :entries

  def self.shared 
    @facebook ||= FacebookModel.new
  end

  # Fetch the data from Facebook via the Graph API, then call the format_data and storeData model to put it in place.
  def request_data
    @entries = nil
    if !@app.fb_session.nil? && @app.fb_session.isOpen
      # Data request to Facebook to retrieve the entries with locations in the home feed.
      request.startWithCompletionHandler(
        lambda do |connection, result, error|
          if error
            raise "Error retrieving the data from Facebook. #{error.localizedDescription}"
            return nil
          else            
            format_data(result["data"])
            return result
          end
        end
      )
    else
      nil
    end
  end

  def format_data(data) 
    entries = []   
    data.each do |entry|
      curr_entry = format_entry_for_app(entry)
      entries << FriendLocationEntryModel.new(curr_entry)
    end
    @entries = entries
    notify_locations_model
  end

  def set_since(var = 1)
    case var
    when 1
      @since = "-1day"
    when 2
      @since = "-2days"
    when 5
      @since = "-5days"
    when 7
      @since = "-7days"
    else
      @since = "-1day"
    end
  end

  def notify_locations_model
    @locations_model.update_locations_data
  end

  def request
    session = @app.fb_session
    FBRequest.alloc.initWithSession(session, graphPath: "me/home?with=location&since=#{@since}&limit=200")
  end

  private
    # Variable handling and init has been made private to prevent creation of several instances.
    def initialize
      @entries = nil
      @since = "-2days"
      @locations_model = LocationsModel.shared
      @app = UIApplication.sharedApplication.delegate
    end

    # Modifies the data retrieved from Facebook accordingly.
    def format_entry_for_app(entry)
      formatted_facebook_entry = FacebookExtras::FacebookEntryFormatter.new(entry).format_entry_from_facebook
    end
  end
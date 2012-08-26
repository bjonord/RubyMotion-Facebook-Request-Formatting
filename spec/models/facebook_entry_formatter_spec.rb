describe FacebookExtras::FacebookEntryFormatter do
  before do
    @entry = {"id"=>"111111111_11111111111111111", "actions"=>[{"link"=>"link_value", "name"=>"Comment"}, {"link"=>"link_value", "name"=>"Like"}], "link"=>"link_value", "privacy"=>{"value"=>"ALL_FRIENDS", "description"=>"Friends"}, "type"=>"photo", "object_id"=>"11111111111111111", "icon"=>"http://static.ak.fbcdn.net/rsrc.php/v2/yM/x/og8V99JVf8G.gif", "place"=>{"id"=>"111111111111111", "name"=>"Place_name", "location"=>{"longitude"=>27.988056, "latitude"=>86.925278}}, "message"=>"Message Content", "from"=>{"id"=>"111111111", "name"=>"User Name"}, "picture"=>"picture_link", "comments"=>{"count"=>0.0}, "created_time"=>"2012-08-25T15:40:54+0000", "updated_time"=>"2012-08-25T15:40:54+0000"}
    @formatter = FacebookExtras::FacebookEntryFormatter.new(@entry)
  end

  it "Should return formatted data with post_id" do
    @formatter.format_entry_from_facebook[:post_id].should.equal("111111111_11111111111111111")
  end

  it "Should return formatted data with longitude and latitude" do
    long = @formatter.format_entry_from_facebook[:longitude]
    lat = @formatter.format_entry_from_facebook[:latitude]
    long.should.equal(27.988056) && lat.should.equal(86.925278)
  end

  it "The returned information should have a created_at value" do
    @formatter.format_entry_from_facebook[:created_at].should.equal("2012-08-25T15:40:54+0000")
  end
end
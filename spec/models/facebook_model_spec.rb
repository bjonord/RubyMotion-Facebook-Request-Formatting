describe FacebookModel do
  before do
    @facebook_model = FacebookModel.shared
    @app = UIApplication.sharedApplication.delegate
  end

  it "Should be a singleton" do 
    FacebookModel.shared.should.equal(@facebook_model)
  end

  it "Should be able to set since" do
    @facebook_model.set_since(7)
    @facebook_model.since.should.equal("-7days")
  end

  it "Request should be a initialised with active session" do
    request = @facebook_model.request
    request.session.should.equal(@app.fb_session)
  end

  it "Request Data should be a FBRequestConnection if session is open and not not nil" do
    @facebook_model.request_data.class.should.equal(FBRequestConnection)
  end

  it "update_data should return nil if FB session is nil" do
    @app.fb_session = nil
    @facebook_model.request_data.should.equal(nil)
  end
end

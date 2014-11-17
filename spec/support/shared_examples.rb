shared_examples "an_unauthenticated_user" do
  it "redirects to the signin_path" do
    logout_user
    http_request     #this is the incoming request
    expect(response).to redirect_to signin_path
  end
end

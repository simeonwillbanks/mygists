require 'spec_helper'

describe ApplicationController do
  # Use the controller method to define an anonymous controller derived from ApplicationController
  # We can request the anonymous controller and test ApplicationController before_filters etc
  controller do
    def index
      render nothing: true
    end
  end

  describe "#set_new_relic_custom_parameters" do
    it "should add remote ip address" do
      parameters = hash_including(remote_ip: request.remote_ip)
      NewRelic::Agent.should_receive(:add_custom_parameters).with(parameters)
    end

    it "should add user agent string" do
      parameters = hash_including(user_agent: request.env["HTTP_USER_AGENT"])
      NewRelic::Agent.should_receive(:add_custom_parameters).with(parameters)
    end

    context "user logged into the site" do
      let(:user) { FactoryGirl.build_stubbed(:user) }
      before(:each) { controller.stub(:current_user).and_return(user) }

      it "should add the logged in users id" do
        parameters = hash_including(user_id: user.id)
        NewRelic::Agent.should_receive(:add_custom_parameters).with(parameters)
      end

      it "should add the logged in users profile username" do
        parameters = hash_including(profile_username: user.profile.username)
        NewRelic::Agent.should_receive(:add_custom_parameters).with(parameters)
      end
    end

    context "user not logged into the site" do
      it "should add an anonymous user id" do
        parameters = hash_including(user_id: "0")
        NewRelic::Agent.should_receive(:add_custom_parameters).with(parameters)
      end

      it "should add an anonymous user profile username" do
        parameters = hash_including(profile_username: "anonymous")
        NewRelic::Agent.should_receive(:add_custom_parameters).with(parameters)
      end
    end

    after(:each) do
      controller.send(:set_new_relic_custom_parameters)
    end
  end
end

require "spec_helper"

describe ProfileDecorator do
  subject(:decorator) { FactoryGirl.build_stubbed(:profile).decorate }

  let(:url) { "https://secure.gravatar.com/avatar/a624cb08e20db3ac4adb6380928a7b11?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png&s=90" }
  let(:username) { decorator.username }
  let(:gravatar_id) { decorator.gravatar_id }

  describe "#gravatar" do
    it "should have a custom gravatar" do
      helper = double("helper")
      decorator.stub(:h).and_return(helper)

      Gravatar.should_receive(:url).with(gravatar_id).and_return(url)

      helper.should_receive(:image_tag).with(url, alt: username,
                                                  width: 90,
                                                  height: 90,
                                                  class: "img-polaroid")
      decorator.gravatar
    end
  end
end

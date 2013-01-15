require "spec_helper"

describe ActsAsTaggableOn::TagDecorator do
  context "default tag" do
    subject(:decorator) { FactoryGirl.build(:tag, name: "Without Tags").decorate }

    it { decorator.name.should eq("Without Tags") }
    it { decorator.classname.should eq("btn") }
    it { decorator.to_s.should eq("Without Tags") }
  end

  context "tag other than default" do
    subject(:decorator) { FactoryGirl.build(:tag, name: "rails").decorate }

    it { decorator.name.should eq("#rails") }
    it { decorator.classname.should eq("btn btn-success") }
    it { decorator.to_s.should eq("#rails") }
  end
end

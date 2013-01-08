require "spec_helper"

describe ActsAsTaggableOn::TagDecorator do
  context "default tag" do
    subject { FactoryGirl.build(:tag, name: "Without Tags").decorate }
    its(:name) { should eq("Without Tags") }
    its(:classname) { should eq("btn") }
    its(:to_s) { should eq("Without Tags") }
  end

  context "tag other than default" do
    subject { FactoryGirl.build(:tag, name: "rails").decorate }
    its(:name) { should eq("#rails") }
    its(:classname) { should eq("btn btn-success") }
    its(:to_s) { should eq("#rails") }
  end
end

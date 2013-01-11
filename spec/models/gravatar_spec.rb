require "spec_helper"

describe Gravatar do
  subject(:klass) { Gravatar }

  let(:id) { "a624cb08e20db3ac4adb6380928a7b11" }
  let(:url) { "https://secure.gravatar.com/avatar/a624cb08e20db3ac4adb6380928a7b11?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png&s=90" }

  it { klass.url(id).should eq(url) }
end

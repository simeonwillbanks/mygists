require "spec_helper"

describe MyGists::Search::Scope do

  subject(:scope) { described_class.new(profile: double("profile"), tag_name: "rails") }

  context "template methods" do

    it { expect { scope.by_profile_tag }.to raise_error(NotImplementedError) }
    it { expect { scope.by_profile }.to raise_error(NotImplementedError) }
    it { expect { scope.by_tag }.to raise_error(NotImplementedError) }
    it { expect { scope.use_default }.to raise_error(NotImplementedError) }
  end
end

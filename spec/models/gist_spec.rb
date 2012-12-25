require 'spec_helper'

describe Gist do
  it { should validate_presence_of(:gid) }
  it { should belong_to(:profile) }
end

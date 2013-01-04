require "spec_helper"

describe MyGists::Secure do
  let!(:data) { "shhhhitsasekret" }

  describe ".encrypt" do
    it "encrypts received string" do
      described_class.encrypt(data).should_not eq(data)
    end
  end

  describe ".decrypt" do
    it "decrypts received string" do
      encrypted = described_class.encrypt(data)
      described_class.decrypt(encrypted).should eq(data)
    end
  end
end

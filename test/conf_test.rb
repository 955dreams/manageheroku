require File.join(File.dirname(__FILE__), 'test_helper')

class ConfTest < MiniTest::Unit::TestCase
  describe "configuration" do
    it "must load the oauth token" do
      conf = Manageheroku::Conf.new(File.join(File.dirname(__FILE__), 'sample_conf.yml'))
      conf.oauth_token.must_equal "the-magic-oauth-token"
    end
  end
end


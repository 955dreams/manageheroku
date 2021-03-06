require File.join(File.dirname(__FILE__), 'test_helper')

class ConfTest < MiniTest::Test
  describe "configuration" do
    it "must load the oauth token" do
      conf = Manageheroku::Conf.new(File.join(File.dirname(__FILE__), 'sample_conf.yml'))
      conf.oauth_token.must_equal "the-magic-oauth-token"
    end

    it "must update all the formations" do
      conf = Manageheroku::Conf.new(File.join(File.dirname(__FILE__), 'sample_conf.yml'))
      conf.formations.first.name.must_equal "myapp-development"
      conf.formations.last.name.must_equal "myapp-performance"
    end

    it "must update all the apps" do
      conf = Manageheroku::Conf.new(File.join(File.dirname(__FILE__), 'sample_conf.yml'))
      conf.apps.first.name.must_equal "myapp-development"
      conf.apps.last.name.must_equal "myapp-staging"
    end

    it "loads fine if there are no apps" do
      conf = Manageheroku::Conf.new(File.join(File.dirname(__FILE__), 'sample_conf_no_apps.yml'))
      conf.formations.first.name.must_equal "myapp-development"
      conf.formations.last.name.must_equal "myapp-performance"
    end

    it "loads fine if there are no formations" do
      conf = Manageheroku::Conf.new(File.join(File.dirname(__FILE__), 'sample_conf_no_formations.yml'))
      conf.apps.first.name.must_equal "myapp-development"
      conf.apps.last.name.must_equal "myapp-staging"
    end

    it "supports ERB magic in the config file" do
      ENV["TEST_VAL"] = "erb_is_great"
      conf = Manageheroku::Conf.new(File.join(File.dirname(__FILE__), 'sample_conf.yml'))
      conf.oauth_token.must_equal "erb_is_great"
      ENV["TEST_VAL"] = nil
    end
  end
end


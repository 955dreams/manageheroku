require File.join(File.dirname(__FILE__), 'test_helper')

class HerokuTest < MiniTest::Test
  describe "heroku" do
    # it "really works" do
    #   conf_file_path = File.join(File.dirname(__FILE__), 'analysis_conf.yml')
    #   heroku = Manageheroku::Heroku.new(conf_file_path)
    #   heroku.update!
    # end
    #
    it "gives rich debug output if exception contains a response" do
      api_stub = ApiStub422.new
      conf_file_path = File.join(File.dirname(__FILE__), 'sample_conf.yml')
      heroku = Manageheroku::Heroku.new(conf_file_path, api_stub)
      assert_raises(Excon::Errors::UnprocessableEntity) do |exp|
        heroku.update!
        heroku.errors.first.must_match /Cannot update the same process twice/
      end
    end

    it "doesn't fail horribly if exception contains a response with no body" do
      api_stub = ApiStubDegenerateCase.new
      conf_file_path = File.join(File.dirname(__FILE__), 'sample_conf.yml')
      heroku = Manageheroku::Heroku.new(conf_file_path, api_stub)
      assert_raises(Excon::Errors::ServiceUnavailable) do |exp|
        heroku.update!
        heroku.errors.first.must_match /500/
      end
    end
  end

  class ApiStub422
    def formation
      FormationStub.new
    end

    class FormationStub
      def batch_update(*params)
        response_params = {body: {"id"=>"Invalid params", "message"=>"Cannot update the same process twice"}.to_json,
                           status: "422"
        }
        raise Excon::Errors::UnprocessableEntity.new("Oh ye gods!", nil, Excon::Response.new(response_params))
      end
    end
  end

  class ApiStubDegenerateCase
    def formation
      FormationStub.new
    end

    class FormationStub
      def batch_update(*params)
        response_params = { status: "503" }
        raise Excon::Errors::ServiceUnavailable.new("Et tu Heroku?", nil, Excon::Response.new(response_params))
      end
    end
  end

end


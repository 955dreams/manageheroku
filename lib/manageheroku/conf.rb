require 'yaml'
module Manageheroku
  class Conf
    def initialize(conf_file)
      @conf_data = {}
      @conf_data = YAML.load_file(conf_file)
    end

    def oauth_token
      @conf_data['oauth-token']
    end

    def formations
      # @conf_data[:apps]
      # TODO return names of all formations in conf file
    end
  end
end

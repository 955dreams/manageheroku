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
      formation_objects = @conf_data["formations"]
      formation_objects.map{|formation_object| Manageheroku::Formation.new(formation_object["name"], formation_object["procs"]) }
    end
  end
end

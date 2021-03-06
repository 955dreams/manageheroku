require 'yaml'
require 'erb'
module Manageheroku
  class Conf
    def initialize(conf_file)
      @conf_data = {}
      @conf_data = YAML.load(ERB.new(Pathname.new(conf_file).read).result)
    end

    def oauth_token
      @conf_data['oauth-token']
    end

    def formations
      formation_objects = @conf_data["formations"]
      return [] unless formation_objects
      formation_objects.map{|formation_object| Manageheroku::Formation.new(formation_object["name"], formation_object["procs"]) }
    end

    def apps
      app_objects = @conf_data["apps"]
      return [] unless app_objects
      app_objects.map{|app_object| Manageheroku::App.new(app_object["name"], app_object)}
    end
  end
end

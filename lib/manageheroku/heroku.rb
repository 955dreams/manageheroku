module Manageheroku
  class Heroku
    def initialize(conf)
      @conf = conf
      @heroku = PlatformAPI.connect_oauth(@conf.oauth_token)
    end

    def update!
      @conf.formations.each do |formation|
        @heroku.formation.batch_update(formation.update_params)
      end
    end
  end
end

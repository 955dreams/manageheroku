module Manageheroku
  class Heroku
    def initialize(conf_file)
      @conf = Manageheroku::Conf.new(conf_file)
      @formations = @conf.formations
      @heroku = PlatformAPI.connect_oauth(@conf.oauth_token)
    end

    def update!
      @formations.each do |formation|
        @heroku.formation.batch_update(*formation.update_params)
      end
    end

  end
end

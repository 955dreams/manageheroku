module Manageheroku
  class Heroku

    attr_reader :errors
    def initialize(conf_file, api_object=nil)
      @conf = Manageheroku::Conf.new(conf_file)
      @formations = @conf.formations
      @apps = @conf.apps
      @heroku = api_object || PlatformAPI.connect_oauth(@conf.oauth_token)
      @errors = []
    end

    def update!
      update_apps!
      update_formations!
    end

    private

    def update_apps!
      @apps.each do |app|
        begin
          @heroku.apps[app.name].update(app.attributes)
        rescue StandardError => e
          log_errors e
          raise e
        end
      end
    end

    def update_formations!
      @formations.each do |formation|
        begin
          @heroku.formation.batch_update(*formation.update_params)
        rescue StandardError => e
          log_errors e
          raise e
        end
      end
    end

    def log_errors(e)
      if e.respond_to?(:response)
        # errors with a response have good information that you miss in stacktrace form
        status = e.response.status
        status_line = e.response.status_line
        response_body_id = nil
        response_body_message = nil
        begin
          body_hash = JSON.parse(e.response.body)
          response_body_id = body_hash["id"]
          response_body_message = body_hash["message"]
        rescue
          response_body_message = e.response.body
        end
        error_string = <<-OUTPUT
              Status: #{[status, status_line].join(";")}
              Body: #{[response_body_id, response_body_message].join(";")}
        OUTPUT
        @errors << error_string
        puts error_string #Heroku logs stdout
      end
    end

  end
end

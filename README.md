# Manageheroku

Manage Heroku App Formations and Apps with YML config files. Allows you to version control important application attributes, and manage configuration for different environments and scenarios.

## Installation

Add this line to your application's Gemfile:

    gem 'manageheroku'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install manageheroku

## Usage

Typical usage is to automate scaling any number of services through config files. For example:

    oauth-token: <%= ENV["HEROKU_OAUTH_TOKEN"] %>
    apps:
      - name: "commerce-app-staging"
        maintenance: false
      - name: "pricing-service-staging"
        maintenance: false
      - name: "messaging-service-staging"
        maintenance: false
    formations:
      - name: "commerce-app-staging"
        procs:
          - process: "web"
            quantity: 4
            size: "standard-2X"
          - process: "resque"
            quantity: 1
      - name: "pricing-service-staging"
        procs:
          - process: "web"
            quantity: 2
          - process: "resque"
            quantity: 1
      - name: "messaging-service-staging"
        procs:
          - process: "web"
            quantity: 2
          - process: "resque"
            quantity: 1

This config file is for an imaginary ecommerce application that is composed of a website, a pricing service and a messaging service. Using manageheroku allows you to apply this configuration to the dyno formation of each application listed in the config file. For example:

      config_file = File.join(Rails.root, 'script', 'config', "black_friday_conf.yml")
      heroku = Manageheroku::Heroku.new(config_file)
      heroku.update!

Your application can programmatically run code like that to scale your applications based on a schedule or whatever your needs are. Currently your dyno formation sizes and quantities are the only things updatable. You can find a list of dyno types in heroku docs https://devcenter.heroku.com/articles/dyno-types

### Apps

The apps section of the config file allows you to configure attributes of a list of apps. Configurable attributes are maintenance mode and build stack. See https://devcenter.heroku.com/articles/platform-api-reference#app-update

### Formations

The formations section of the config file allows you to configure dyno formations for a list of apps. See https://devcenter.heroku.com/articles/platform-api-reference#formation-batch-update for details.

### Real World Usage

We have manageheroku config files for shutting down and starting up all of our internal environments: development, staging and performance. Then with cron (or resque scheduler) all these environments shut down at 8pm and start back up at 8am, so we're not paying for loads of resources that aren't being used.  We also use manageheroku config files for storing various interesting configurations of the application for our performance testing environments.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/manageheroku/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Releases

Bundler created the gem boilerplate and can release it for us.

Test with

`gem build manageheroku.gemspec`

For Realz

`bundle exec rake release`

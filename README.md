# UptimeFunk (temporary name)

## Description

UptimeFunk is a web-app that provides uptime for the various lines of the Paris public transportation system.

## Development

### Pre-requisites

1. Install [``docker``|https://docs.docker.com/installation/#installation] and [``docker-compose``|https://docs.docker.com/compose/install/].
2. If you're on OSX, install [``boot2docker``|http://boot2docker.io/] as well
3. If you like doing things manuall, just disregard all the Docker-foo! 

### Running the app

Simply executing the following commands should be enough to get you started:

```
docker-compose build
docker-compose up
docker-compose run web rake db:create
```

To execute any rake/rails command, or to get a shell:

```
docker-compose run web COMMAND TO ISSUE (/bin/bash for example)
```

When modifiyng the Gemfile or the Docker file, run the following command once again:

```
docker-compose build
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Don't forget to run the tests with `rake`.

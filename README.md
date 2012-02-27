# Minegems

## Requirements

  * Ruby 1.9 (with Bundler 1.1.rc)
  * Pow
  * Redis 2.2+
  * MongoDB 2.0+
  * PostgreSQL 9.1+

## Development

    $ git clone git@github.com:jodosha/minegems.git
    $ cd minegems && bundle
    $ bundle exec rake app:setup

The setup process creates a `Procfile` for [Foreman](http://ddollar.github.com/foreman/),
we advise to keep it up and running alongside the whole development session:

    $ foreman start

The application is avaliable at
[http://minegems.dev](http://minegems.dev) and its already configured
for subdomains usage.

## Testing

Be sure Foreman is running, then:

    $ bundle exec rake

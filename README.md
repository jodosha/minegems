# Minegems

Multi-tenancy private gem hosting.

**This project isn't actively maintained, I just open sourced because it may be useful for your business.**

## Usage

This software is deployable on Heroku (yes, it works with the read-only file system) and requires an Amazon S3 bucket.
It supports multi-tenancy separation of contents, authentication and authorization, with third level domains approach.

**It only supports the old gem index**

Example:

In your Gemfile add `source 'http://deploy:token@account.example.org'`, before of 'https://rubygems.org'.



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

## Presentation
[![Minegems presentation on Slideshare](http://image.slidesharecdn.com/minegems-110308104612-phpapp02/95/slide-1-1024.jpg?1299602822)](http://www.slideshare.net/jodosha/minegems)

## Copyright
2011 - 2013 Luca Guidi - http://lucaguidi.com, released under the MIT license

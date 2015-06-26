# FROM ruby:2.2.0
#
# RUN apt-get update -qq && apt-get install -y build-essential
#
# # for postgres
# RUN apt-get install -y libpq-dev
#
# # for nokogiri
# RUN apt-get install -y libxml2-dev libxslt1-dev
#
# # for capybara-webkit
# RUN apt-get install -y libqt4-webkit libqt4-dev xvfb
#
# # for a JS runtime
# RUN apt-get install -y nodejs
#
# RUN apt-get install -y postgresql-client
#
# ENV APP_HOME /myapp
# RUN mkdir $APP_HOME
# WORKDIR $APP_HOME
#
# ADD Gemfile* $APP_HOME/
# RUN bundle install
#
# ADD . $APP_HOME
#

# === 1 ===
FROM phusion/passenger-ruby21:0.9.12
MAINTAINER Jeroen van Baarsen "jeroen@firmhouse.com"

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# === 2 ===
# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down

# === 3 ====
# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Add the nginx info
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf

# === 4 ===
# Prepare folders
RUN mkdir /home/app/webapp

# === 5 ===
# Run Bundle in a cache efficient way
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install

# === 6 ===
# Add the rails app
ADD . /home/app/webapp

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

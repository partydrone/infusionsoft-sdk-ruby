FROM ruby:2.7-buster
LABEL author="Andrew Porter <partydrone@icloud.com>"

WORKDIR /opt/ruby
COPY . .
RUN bundle install

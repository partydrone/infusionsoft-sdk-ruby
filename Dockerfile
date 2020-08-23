FROM ruby:2.7-buster
LABEL author="Andrew Porter <partydrone@icloud.com>"

WORKDIR /opt/ruby
COPY Gemfile* *.gemfile ./
RUN bundle install
COPY . .

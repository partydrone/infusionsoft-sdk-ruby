FROM ruby:2.7-buster
LABEL author="Andrew Porter <partydrone@icloud.com>"

ENV GEM_NAME infusionsoft

WORKDIR /opt/gem
COPY Gemfile* *.gemspec ./
COPY lib/${GEM_NAME}/version.rb ./lib/${GEM_NAME}/version.rb
RUN bundle install
COPY . .

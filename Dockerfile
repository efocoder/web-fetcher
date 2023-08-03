FROM ruby:3.1.3
WORKDIR /app
COPY . /app/

RUN gem install bundler

RUN bundle install
RUN chmod +x fetch.rb
FROM ruby:2.7.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /stocket-api
COPY Gemfile /stocket-api/Gemfile
COPY Gemfile.lock /stocket-api/Gemfile.lock
RUN bundle install
COPY . /stocket-api

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "$STOCKET_HOST_IP"]
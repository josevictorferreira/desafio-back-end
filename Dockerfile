FROM ruby:2.6.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /cnab_parser
WORKDIR /cnab_parser
COPY /cnab_parser/Gemfile /cnab_parser/Gemfile
COPY /cnab_parser/Gemfile.lock /cnab_parser/Gemfile.lock
RUN bundle install
COPY /cnab_parser /cnab_parser

COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

FROM ruby:2.2

RUN mkdir /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN cd /app && bundle install -j4 --deployment
COPY . /app
WORKDIR /app

CMD ["bundle", "exec", "foreman", "start"]
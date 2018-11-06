FROM ruby:2.4

RUN mkdir /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN cd /app && bundle install -j8 --deployment
COPY . /app
WORKDIR /app

EXPOSE 5000
CMD ["bundle", "exec", "foreman", "start"]
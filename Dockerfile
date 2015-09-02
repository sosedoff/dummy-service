FROM ruby:2.2

RUN mkdir /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN cd /app && bundle install -j8 --deployment
COPY . /app
WORKDIR /app

EXPOSE 5000
CMD ["foreman", "start"]
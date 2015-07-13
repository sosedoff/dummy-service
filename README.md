# dummy-service

Very simple Sinatra application to help testing verious things

## Install

Clone repository and install dependencies with Bundler:

```
git clone https://github.com/sosedoff/dummy-service.git
cd dummy-service
bundle install
```

## Run

Simply execute the following command:

```
foreman start
```

Server should be available on `http://localhost:5000`

## Docker

Project includes a very basic Dockerfile. To build image run:

```
docker build -t dummy .
```

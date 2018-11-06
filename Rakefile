namespace :docker do
  task :build do
    sh "docker build -t sosedoff/dummy-service ."
  end

  task :push do
    sh "docker push sosedoff/dummy-service"
  end
end
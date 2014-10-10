task :generate do
  puts '-- Generating site with Middleman --'
  system './bin/middleman build --clean'
end

task :push do
  puts '-- Pushing site up via rsync --'
  system 'rsync -avz --delete -e ssh ./build/ SSH_LOGIN_PATH'
end

desc 'Deploying site...'
task deploy: [:generate, :push] do
end

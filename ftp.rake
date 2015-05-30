# ====================================
#   Deploy: FTP
# ====================================

# ----- Variables ----- #

SSH_USER = 'root'
SSH_HOST = 'www.example.com'
SSH_DIR  = '/var/www/html/www.example.com'

# ----- Generate ----- #

desc 'Generate flat files with Middleman'
task :generate do
  puts '-- Generating site with Middleman --'
  system './bin/middleman build --clean'
end

# ----- Push ----- #

desc 'Push the build to the server via rsync'
task :push do
  puts '-- Pushing site up via rsync --'
  system "rsync -avz --delete -e ssh ./build/ #{ SSH_USER }@#{ SSH_HOST }:#{ SSH_DIR }"
end

# ----- Deploy ----- #

desc 'Generate flat files and deploy via rsync to server'
desc 'Deploying site...'
task deploy: [:generate, :push] do
end

# ====================================
#   Deploy: FTP (with staging)
# ====================================

# ----- Variables ----- #

SSH_USER = 'root'
SSH_HOST = 'www.example.com'
SSH_DIR  = '/var/www/html/www.example.com'

# ----- Deploy ----- #

namespace :deploy do

  # ----- Generate ----- #

  desc 'Generate flat files with Middleman'
  task :generate do
    puts '-- Generating site with Middleman --'
    system './bin/middleman build --clean'
  end

  # ----- Production ----- #

  desc 'Push the build to the production server via rsync'
  task :production => [:generate] do
    puts '-- Pushing site up via rsync --'
    system "rsync -avz --delete -e ssh ./build/ #{ SSH_USER }@#{ SSH_HOST }:#{ SSH_DIR }"
  end

  # ----- Staging ----- #

  desc 'Push the build to the staging server via rsync'
  desc 'Generate flat files and deploy via rsync to staging server'
  task :staging => [:generate] do
    system "rsync -avz --delete -e ssh ./build/ #{ SSH_USER }@#{ SSH_HOST }:#{ SSH_DIR }"
  end
end

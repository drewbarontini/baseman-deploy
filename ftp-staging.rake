namespace :deploy do
  task :generate do
    puts "## Generating site with Middleman"
    system "./bin/middleman build --clean"
  end

  task :production => [:generate] do
    system "rsync -avz --delete -e ssh ./build/ SSH_LOGIN_PATH"
  end

  task :staging => [:generate] do
    system "rsync -avz --delete -e ssh ./build/ SSH_LOGIN_PATH"
  end
end

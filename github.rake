# ====================================
#   Deploy: GitHub Pages
# ====================================

# ----- Variables ----- #

REPO_URL = ''

# ----- Generate ----- #

desc 'Generate flat files with Middleman'
task :generate do
  puts '-- Generating site with Middleman --'
  system './bin/middleman build --clean'
  cd 'build' do
    system 'git init'
    system "git remote add origin #{ REPO_URL }"
  end
end

# ----- Push ----- #

desc 'Push the build to the gh-pages branch on GitHub'
task :push do
  puts '-- Deploying build to GitHub Pages --'
  cd 'build' do
    system 'git add .'
    system 'git add -u'
    system "git commit -m 'Site updated at #{Time.now.utc}'"
    system 'git push origin master:gh-pages --force'
  end
end

# ----- Deploy ----- #

desc 'Generate flat files and deploy to GitHub Pages'
task :deploy => [:generate, :push] do
end

require_relative 'lib/assets'

task :precompile do
  %w[
    assets/javascripts/base.js
    assets/stylesheets/application.css
  ].each do |path|
    puts "Compiling #{path}..."
    File.write(path, ASSETS[path])
  end
end

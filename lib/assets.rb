require 'sprockets'
require 'autoprefixer-rails'

ASSETS = Sprockets::Environment.new do |env|
  env.append_path('.')
end

AutoprefixerRails.install(ASSETS)

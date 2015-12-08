require 'sprockets'
require 'autoprefixer-rails'

assets = Sprockets::Environment.new do |env|
  env.append_path('.')
end

AutoprefixerRails.install(assets)

run assets

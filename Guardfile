# coding: UTF-8
notification :terminal_notifier
interactor :coolline

guard :jasmine, :server => :thin do
  watch(%r{spec/javascripts/spec\.(js\.coffee|js|coffee)$})         { "spec/javascripts" }
  watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
  watch(%r{vendor/assets/javascripts/(.+?)\.(js\.coffee|js|coffee).erb$})  { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
end

guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{ m[1] }_spec.rb" }
end

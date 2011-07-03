begin
  require 'irb/completion'
  require 'irb/ext/save-history'
  require 'rubygems'
  require 'wirble' #if Gem.available?('wirble')

  Wirble.init
  Wirble.colorize

  colors = Wirble::Colorize.colors.merge({
    :object_class => :purple,
    :symbol => :purple,
    :symbol_prefix => :purple
  })
  Wirble::Colorize.colors = colors

rescue Exception => e
  puts e.message
end


require 'irb/completion'
require 'irb/ext/save-history'
require 'rubygems'
require 'wirble'

Wirble.init
Wirble.colorize
Wirble::Colorize.colors.merge!({
  :object_class => :purple,
  :symbol => :purple,
  :symbol_prefix => :purple
})


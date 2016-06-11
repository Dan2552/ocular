CHILD_PROCESS = `require('child_process')`
require 'console'

def puts(str)
  $console.log(str)
end

class Object
  def self.attr_accessor(*args)
    attr_reader(*args)
    attr_writer(*args)
  end
end

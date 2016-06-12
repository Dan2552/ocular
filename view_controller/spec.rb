class Spec
  attr_accessor :command,
                :description,
                :state

  def initialize(command: nil, description: nil, state: :untested)
    self.command = command
    self.description = description
    self.state = state
  end

  def file
    command.match(".\/(.*.rb)")[1]
  end

  def index
    command.match("#{file}(.*)$")[1]
  end
end

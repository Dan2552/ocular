class Spec
  attr_accessor :command,
                :description,
                :state

  def initialize(command: nil, description: nil, state: :untested)
    self.command = command
    self.description = description
    self.state = state
  end
end

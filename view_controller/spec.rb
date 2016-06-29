class Spec
  attr_accessor :id,
                :description,
                :state,
                :file_location

  def initialize(id: nil, description: nil, state: :untested, file_location: nil)
    self.id = id
    self.description = description
    self.state = state
    self.file_location = file_location
  end

  def file
    file_location.match("^(.*):")[1]
  end

  def icon_class
    case state
    when :untested
      "hourglass-start"
    when :success
      "check"
    when :failure
      "times"
    when :pending
      "pencil"
    end
  end
end

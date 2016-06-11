class AppState
  def self.shared_instance
    @shared_instance ||= AppState.new
  end

  def self.reset
    @shared_instance = nil
  end

  #########################

  attr_reader :project_path,
              :observers

  def initialize
    @observers = []
    clear_specs!
  end

  def project_path=(set)
    @project_path = set
    observer_message(:project_path_was_set)
  end

  def specs
    @specs.freeze
  end

  def add_spec(spec)
    @specs << spec
    observer_message(:spec_was_added)
  end

  def clear_specs!
    @specs = []
  end

  def observer_message(message)
    observers.each { |o| o.send(message) }
  end

  def progress
    # TODO: stub. This should generate from @specs objects
    {
      untested: 100,
      success: 0,
      failure: 0,
      pending: 0
    }
  end
end

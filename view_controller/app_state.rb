class AppState
  def self.shared_instance
    @shared_instance ||= AppState.new
  end

  def self.reset!
    observer = shared_instance.observer
    observer.reset!
    @shared_instance = nil
    shared_instance.observer = observer
  end

  #########################

  attr_reader :project_path
  attr_accessor :observer

  def initialize
    clear_specs!
  end

  def project_path=(set)
    @project_path = set
    observer.project_path_was_set
  end

  def specs
    @specs.freeze
  end

  def add_or_update_spec(spec)
    unless specs_include?(spec)
      @specs << spec
    end

    observer.add_or_update_spec(spec)
    observer.progress_update
  end

  def log_to_console(log)
    observer.log_to_console(log)
  end

  def clear_specs!
    @specs = []
  end

  def progress
    {
      untested: @specs.select { |s| s.state == :untested }.count,
      success: @specs.select { |s| s.state == :success }.count,
      failure: @specs.select { |s| s.state == :failure }.count,
      pending: @specs.select { |s| s.state == :pending }.count,
      total: @specs.count
    }
  end

  #########################

  private

  def specs_include?(spec)
    @specs.each { |s| return true if s.id == spec.id }
    false
  end
end

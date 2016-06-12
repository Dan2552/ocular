class AppState
  def self.shared_instance
    @shared_instance ||= AppState.new
  end

  def self.reset
    @shared_instance = nil
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

  def add_spec(spec)
    @specs << spec
    observer.spec_was_added(spec)
    observer.progress_update
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
end

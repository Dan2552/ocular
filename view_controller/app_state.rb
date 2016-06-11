class AppState
  def self.shared_instance
    @shared_instance ||= AppState.new
  end

  def self.reset
    @shared_instance = nil
  end

  def options
    # TODO: unhardcode
    @options ||= {
      project_path: "/Users/dan2552/projects/evie/"
    }
  end

  def specs
    @specs ||= []
  end

  def clear_specs!
    @specs = []
  end

  def project_path
    options[:project_path]
  end
end

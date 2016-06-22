class RSpec
  def run
    puts "dry run"

    project_path = AppState.shared_instance.project_path
    return unless project_path

    AppState.shared_instance.clear_specs!
    AppState.shared_instance.log_to_console("<strong># Launching Rspec</strong>")

    rspec = Electron.child_process.spawn("./rspec_integration/launch_rspec.sh", [project_path])

    rspec.stdout.on("data") do |data|
      lines_from_data(data).each { |line| handle_test_result_line(line) }
    end

    rspec.stderr.on("data") do |data|
      lines_from_data(data).each { |line| AppState.shared_instance.log_to_console(line) }
    end

    rspec.on("close") do |code|
      AppState.shared_instance.log_to_console("Rspec run finished with status: #{code}")
      yield
    end
  end

  def handle_test_result_line(line)
    splitter = "---|-|---"
    return unless line.include?(splitter)

    file_location, id, state, description = line.split(splitter)
    spec = Spec.new id: id,
                    file_location: file_location,
                    state: state,
                    description: description

    AppState.shared_instance.add_or_update_spec(spec)
  end

  private

  def lines_from_data(data)
    data.JS.toString.split(/(\r?\n)/)
  end
end

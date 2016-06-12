class RSpec
  def self.process_dry_run
    puts "dry run"

    project_path = AppState.shared_instance.project_path
    return unless project_path

    AppState.shared_instance.clear_specs!
    AppState.shared_instance.log_to_console("<strong># Launching dry run</strong>")
    Electron.exec("./rspec_integration/launch_dry_run.sh #{project_path}", {}) do |error, stdout, stderr|
      lines = stdout.split(/(\r?\n)/)
      lines = lines.select { |l| l.include?("rspec")}

      lines.each do |line|
        AppState.shared_instance.log_to_console(line)
      end

      error_lines = stderr.split(/(\r?\n)/)
      error_lines.each do |line|
        AppState.shared_instance.log_to_console(line)
      end

      lines.each do |line|
        AppState.shared_instance.log_to_console(line)
        command, description = line.split(" # ")
        spec = Spec.new(command: command, description: description)
        AppState.shared_instance.add_spec(spec)
      end

      AppState.shared_instance.specs.each do |spec|
        puts spec
      end
      AppState.shared_instance.log_to_console("<br/>")
      yield
    end
  end

  def self.run_all
    # TODO
    alert("unimplemented")
  end
end

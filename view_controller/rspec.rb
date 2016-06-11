class RSpec
  def self.process_dry_run
    puts "dry run"

    project_path = AppState.shared_instance.project_path
    return unless project_path

    AppState.shared_instance.clear_specs!

    Electron.exec("./rspec_integration/launch_dry_run.sh #{project_path}", {}) do |error, stdout, stderr|
      lines = stdout.split(/(\r?\n)/)
      lines = lines.select { |l| l.include?("rspec")}
      specs = lines.each do |line|
        command, description = line.split(" # ")
        spec = Spec.new(command: command, description: description)
        AppState.shared_instance.add_spec(spec)
      end
      AppState.shared_instance.specs.each do |spec|
        puts spec
      end
    end
  end

  def self.run_all
    # TODO
    alert("unimplemented")
  end
end

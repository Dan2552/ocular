class UIEventHandler
  def initialize
    Element.find('#btn-run-all-tests').on :click do
      RSpec.run_all
    end

    Element.find('#btn-choose-project-dir').on :click do
      AppState.shared_instance.project_path = Electron.show_open_dialog
    end

    AppState.shared_instance.observers << self
  end

  def project_path_was_set
    element = Element.find("#input-project-dir")
    element.value = AppState.shared_instance.project_path
    RSpec.process_dry_run
  end

  def spec_was_added
    puts "spec added"
  end

  def progress_update
    # TODO: use `AppState.shared_instance.progress` to render correct progress bar
  end
end

APP_STATE_HANDLER = UIEventHandler.new

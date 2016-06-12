class UIEventHandler
  def initialize
    Element.find("#btn-choose-project-dir").on(:click) do
      AppState.reset!
      AppState.shared_instance.project_path = Electron.show_open_dialog
    end

    Element.find("#btn-sidebar-check").on(:click) do
      Element.find("#check-content").show
      Element.find("#console-content").hide
      Element.find("#btn-sidebar-check").add_class("glyphicon-active")
      Element.find("#btn-sidebar-console").remove_class("glyphicon-active")
    end

    Element.find("#btn-sidebar-console").on(:click) do
      Element.find("#check-content").hide
      Element.find("#console-content").show
      Element.find("#btn-sidebar-check").remove_class("glyphicon-active")
      Element.find("#btn-sidebar-console").add_class("glyphicon-active")
    end

    AppState.shared_instance.observer = self
  end

  def reset!
    Element.find("#spec-results").empty
    Element.find("#console-content").html = ""
  end

  def project_path_was_set
    element = Element.find("#input-project-dir")
    element.value = AppState.shared_instance.project_path
    progress_update
    RSpec.process_dry_run do
      progress_update(active: false)
    end
  end

  def spec_was_added(spec)
    panel_id = spec.file.gsub("./", "").gsub("/", "-").gsub(".rb", "")
    panel = Element.id(panel_id)
    unless panel
      panel = HtmlElements.create_panel(
        id: panel_id,
        title: spec.file
      )

      Element.find("#spec-results").append(panel)
    end

    spec_buttons_container = Element.id("#{panel_id}-content")

    spec_button_id = "#{panel_id}-#{spec.index}"
    spec_button = Element.id(spec_button_id)
    unless spec_button
      spec_button = HtmlElements.spec_button(id: spec_button_id, icon: "hourglass-start")
      spec_buttons_container.append(spec_button)
    end
  end

  def progress_update(active: true)
    states = [
      :success,
      :failure,
      :pending,
      :untested
    ]

    puts "progress update"
    progress = AppState.shared_instance.progress

    states.each do |state|
      element = element_for_state(state)
      if active
        element.add_class("active")
        element.add_class("progress-bar-striped")
      else
        element.remove_class("active")
        element.remove_class("progress-bar-striped")
      end
    end

    if progress[:total] == 0
      element_for_state("untested").css("width", "100%")
      return
    end

    states.each do |state|
      element = element_for_state(state)
      percent = (progress[state].to_f / progress[:total].to_f) * 100
      element.css("width", "#{percent}%")
    end
  end

  def log_to_console(log)
    console_content = Element.find("#console-content")
    console_content.html = console_content.html + "</br>" + log
  end

  private

  def element_for_state(state)
    Element.find("#spec-progress-#{state}")
  end
end

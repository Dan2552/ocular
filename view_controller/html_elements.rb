class HtmlElements
  def self.create_panel(id: nil, title: nil)
    panel = <<-HTML
      <div id="#{id}" class="panel panel-info">
        <div class="panel-heading">
          <h3 class="panel-title">#{title}</h3>
        </div>
        <div id="#{id}-content" class="panel-body"></div>
      </div>
    HTML
    Element.parse(panel)
  end

  def self.spec_button(id: nil, icon: icon)
    spec_button = <<-HTML
      <button id="#{id}" class="btn btn-default btn-xs dropdown-toggle fa fa-#{icon}" type="button">
      </button>
    HTML
    Element.parse(spec_button)
  end
end

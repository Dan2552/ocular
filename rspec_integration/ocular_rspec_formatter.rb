require 'rspec/core/formatters/base_text_formatter'

class OcularRSpecFormatter
  # This registers the notifications this formatter supports, and tells
  # us that this was written against the RSpec 3.x formatter API.
  RSpec::Core::Formatters.register self, :example_passed, :example_failed, :example_pending

  def initialize(output)
    @output = output
  end

  def example_passed(notification)
    example_output(notification, "success")
  end
  def example_failed(notification)
    example_output(notification, "failure")
  end
  def example_pending(notification)
    example_output(notification, "pending")
  end

  def example_output(notification, status)
    e = notification.example
    s = "---|-|---"
    @output << "#{e.location_rerun_argument}#{s}#{e.id}#{s}#{status}#{s}#{e.full_description}\n"
  end
end

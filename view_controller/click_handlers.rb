Element.find('#btn-run-all-tests').on :click do
  RSpec.process_dry_run
end

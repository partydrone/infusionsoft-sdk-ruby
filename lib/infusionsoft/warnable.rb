module Infusionsoft
  module Warnable
    def infusionsoft_warn(*message)
      unless ENV["INFUSIONSOFT_SILENT"]
        warn message
      end
    end
  end
end

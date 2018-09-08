
require 'keytechKit/classes/layout/control'

module KeytechKit
  class Layout
    attr_accessor :controls

    def initialize(data)
      puts "data= #{data}"
      parseControls(data["DesignerControls"])
    end

    private

    def parseControls(data)
      self.controls = Array.new
      data.each do |controlData|
        control = Control.new(controlData)
        self.controls.push control
      end
    end
  end
end

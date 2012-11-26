require 'plist'
require 'yaml'
class PlistParser
  attr_accessor :path, :plist, :ui_data

  def load_from_file(path)
    self.path = path
    self.plist = Plist::parse_xml(self.path)
  end

  def extract_ui
    self.ui_data = []
    extract_ui(plist['All Samples'].first)
  end

  def extract_ui(element)
    [parse_message(element['Message']), element['children'].collect {|c| extract_ui(c)}].flatten
  end

  def parse_message(message)
    message
  end

  def parse_rect(rect)
    matches = rect.match(/{{(\d+), (\d+)}, {(\d+), (\d+)}}/)
    { origin: { x: matches[1].to_i, y: matches[2].to_i },
      size:   { width: matches[3].to_i, height: matches[4].to_i } }
  end
end
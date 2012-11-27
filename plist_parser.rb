require 'plist'
require 'yaml'
require 'strscan'

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

  def wtf(message)

    class_name = /(\w+):/.match(message)[1]
    rect_values =
    # matches.each do |m|
    #   puts m
    # end

    # scanner = StringScanner.new(message)
    # class_name = scanner.scan(/\w+/)
    # scanner.scan(/: /)
    # parts = scanner.scan(/.*/)
    # # parts = []
    # # while !scanner.eos?
    # #   key = scanner.scan(/: /)
    # #   value = nil
    # #   parts << [key, value]
    # # end
    # { :class => class_name, :parts => parts }
  end
  wtf("UIAButton: name:Recent rect:{{82, 432}, {76, 48}}")

  def parse_message(message)
    message
  end

  def parse_message_parts(message)
    matches = message.match /(\w+): .*/
    class_name = matches[1]
    rest = matches[2]

  end

  def parse_rect(rect)
    matches = rect.match(/{{(\d+), (\d+)}, {(\d+), (\d+)}}/)
    { origin: { x: matches[1].to_i, y: matches[2].to_i },
      size:   { width: matches[3].to_i, height: matches[4].to_i } }
  end
end
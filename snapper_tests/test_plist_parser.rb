require 'test/unit'
require_relative '../plist_parser.rb'

class TestPlistParser < Test::Unit::TestCase
  def setup
    @parsed_elements = ["UIAWindow: rect:{{0, 0}, {320, 480}}", "UIAElement: name:STEVENS WAY & PEND OREILLE RD, NE bound - Routes: 25, 65, 67, 68, 75, 372, 373 rect:{{192, -35}, {35, 35}}", "UIAElement: name:STEVENS WAY & PEND OREILLE RD, S bound - Routes: 25, 31, 32, 65, 67, 68, 75, 205, 277, 372, 373, 540, 810, 821, 855, 860, 871, 880, 885 rect:{{179, -12}, {30, 41}}", "UIAElement: name:STEVENS WAY & BENTON LN, S bound - Routes: 25, 31, 32, 65, 67, 68, 75, 205, 277, 372, 373, 540, 810, 821, 855, 860, 871, 880, 885 rect:{{164, 162}, {30, 41}}", "UIAElement: name:STEVENS WAY & BENTON LN, N bound - Routes: 25, 65, 67, 68, 75, 372, 373 rect:{{173, 207}, {30, 41}}", "UIAElement: name:MONTLAKE BLVD NE & HEC ED PAVILION, NE bound - Routes: 243 rect:{{259, 310}, {35, 35}}", "UIAElement: name:STEVENS WAY & GARFIELD LN, W bound - Routes: 25, 31, 32, 65, 67, 68, 75, 205, 277, 372, 373, 540, 810, 821, 855, 860, 871, 880, 885 rect:{{6, 320}, {41, 30}}", "UIAElement: name:STEVENS WAY & OKANOGAN LN, E bound - Routes: 25, 65, 67, 68, 75, 372, 373 rect:{{-3, 328}, {41, 30}}", "UIAElement: name:NE PACIFIC PL & NE PACIFIC ST, E bound - Routes: 44, 48 rect:{{59, 434}, {41, 30}}", "UIAElement: name:NE PACIFIC ST & NE PACIFIC PL, NW bound - Routes: 25, 43, 44, 48, 167, 271, 277, 540, 542, 556 rect:{{61, 432}, {35, 35}}", "UIAElement: name:NE PACIFIC PL & NE PACIFIC ST, E bound - Routes: 48 rect:{{126, 434}, {41, 30}}", "UIAElement: name:MONTLAKE BLVD NE & NE PACIFIC PL, SW bound - Routes: 243 rect:{{205, 429}, {35, 35}}", "UIAElement: name:NE PACIFIC ST & NE PACIFIC PL, SE bound - Routes: 25, 43, 48, 133, 167, 197, 205, 271, 277, 540, 542, 556, 586 rect:{{85, 462}, {35, 35}}", "UIAElement: name:Current Location rect:{{-256, 3036}, {23, 23}}", "UIAMapView: rect:{{0, 64}, {320, 367}}", "UIAStaticText: name:Legal value:Legal rect:{{11, 411}, {24, 11}}", "UIAActivityIndicator: name:Progress halted value:0 rect:{{16, 80}, {28, 28}}", "UIAImage: rect:{{20, 84}, {20, 20}}", "UIANavigationBar: rect:{{0, 20}, {320, 44}}", "UIAImage: rect:{{0, 20}, {320, 44}}", "UIAImage: rect:{{0, 0}, {320, 3}}", "UIAButton: name:Locate Me rect:{{5, 27}, {35, 30}}", "UIAImage: rect:{{48, 20}, {220, 44}}", "UIASegmentedControl: rect:{{48, 20}, {220, 44}}", "UIAImage: rect:{{48, 20}, {220, 44}}", "UIAImage: rect:{{48, 64}, {220, 3}}", "UIAButton: name:Title value:1 rect:{{53, 27}, {105, 30}}", "UIAButton: name:Title rect:{{159, 27}, {104, 30}}", "UIASearchBar: value:Search rect:{{53, 26}, {210, 31}}", "UIAButton: rect:{{276, 27}, {39, 30}}", "UIAToolbar: rect:{{0, 431}, {320, 44}}", "UIAImage: rect:{{0, 428}, {320, 3}}", "UIAImage: rect:{{0, 431}, {320, 44}}", "UIATabBar: rect:{{0, 431}, {320, 49}}", "UIAImage: rect:{{0, 428}, {320, 3}}", "UIAImage: rect:{{0, 431}, {320, 49}}", "UIAButton: name:Map value:1 rect:{{2, 432}, {76, 48}}", "UIAButton: name:Recent rect:{{82, 432}, {76, 48}}", "UIAButton: name:Bookmarks rect:{{162, 432}, {76, 48}}", "UIAButton: name:Info rect:{{242, 432}, {76, 48}}"]

    @plist_file_path = File.join(File.dirname(__FILE__), 'test_data.plist')
    @parser = PlistParser.new
  end

  def test_load_from_file
    @parser.load_from_file(@plist_file_path)
    assert_not_nil(@parser.plist)
    assert_equal(@parser.plist.class, Hash)
  end

  def test_parse_rect
    rect = { origin: { x: 1, y: 2 },
             size:   { width: 3, height: 4 } }
    assert_equal(rect, @parser.parse_rect("{{1, 2}, {3, 4}}"))
  end

  def test_parse_message_parts
    assert_equal(["UIAToolbar", "rect:{{0, 431}, {320, 44}}"], @parser.parse_message_parts("UIAToolbar: rect:{{0, 431}, {320, 44}}"))
    assert_equal(["UIAButton", "name:Recent", "rect:{{82, 432}, {76, 48}}"], @parser.parse_message_parts("UIAButton: name:Recent rect:{{82, 432}, {76, 48}}"))
    # and "UIAButton: name:Map value:1 rect:{{2, 432}, {76, 48}}"
  end

  # def test_parse_message
  #   message = "UIAWindow: rect:{{0, 0}, {320, 480}}"
  #   parsed = @parser.parse_message(message)
  #   assert_equal(parsed, {:class => 'UIAWindow', :rect => {:origin => {}}})
  #   "rect" => {
  #     "origin" => {
  #       "x" => 0,
  #       "y" => 0
  #     },
  #     "size" => {
  #       "width" => 320,
  #       "height" => 480
  #     }
  #   },
  # end
end
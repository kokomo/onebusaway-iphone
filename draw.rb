require 'RMagick'

# TODO: handle landscape orientation!

class ImageAnnotator
  attr_accessor :canvas, :context, :views, :scale

  def initialize(image_path, views)
    self.canvas = Magick::Image.read(image_path).first
    self.context = Magick::Draw.new
    self.views = views
    self.scale = self.canvas.columns / 320
  end

  def annotate!
    views.each do |v|
      next unless !!v['isValid'] && !!v['isVisible']

      context.fill(color)
      context.fill_opacity(0.8)
      coords = cgrect_to_coords(v['rect'])
      context.rectangle(*coords)

      unless v['label'].nil? && v['name'].nil?
        context.fill('black')
        context.fill_opacity(1.0)
        context.text(coords[0], coords[1], v['label'] || v['name'])
      end
    end
    # {
    #   "label" => nil,
    #   "name" => nil,
    #   "value" => nil,
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
    #   "hint" => nil,
    #   "isValid" => true,
    #   "isVisible" => true,
    #   "stringValue" => "[object UIAWindow]"
    # }
  end

  def write(path)
    context.draw(canvas)
    canvas.write(path)
  end

  private

  def cgrect_to_coords(rect)
    origin_x = rect['origin']['x'] * scale
    origin_y = rect['origin']['y'] * scale

    width = rect['size']['width'] * scale
    height = rect['size']['height'] * scale
    [
      origin_x, origin_y,
      origin_x + width, origin_y + height
    ]
  end

  def color
    %w{aqua blue fuchsia gray green lime maroon navy olive purple red silver teal yellow}.sample
  end
end

# gc.stroke('transparent')
# gc.fill('black')
# gc.fill_opacity(0.5)
# gc.rectangle(10, 10, 210, 180)

# # Draw ellipse
# gc.stroke('red')
# gc.stroke_width(3)
# gc.fill_opacity(0)
# gc.ellipse(120, 150, 80, 120, 0, 270)
#
# # Draw endpoints
# gc.stroke('gray50')
# gc.stroke_width(1)
# gc.circle(120, 150, 124, 150)
# gc.circle(200, 150, 204, 150)
# gc.circle(120,  30, 124,  30)
#
# # Draw lines
# gc.line(120, 150, 200, 150)
# gc.line(120, 150, 120,  30)
#
# # Annotate
# gc.stroke('transparent')
# gc.fill('black')
# gc.text(130, 35, "End")
# gc.text(188, 135, "Start")
# gc.text(130, 95, "'Height=120'")
# gc.text(55, 155, "'Width=80'")
#

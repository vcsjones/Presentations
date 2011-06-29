class Ellipse
  attr_accessor :width
  attr_accessor :height
end


class Circle < Ellipse
  def circumference
    Math::PI * @width
  end
end

c = Circle.new()
c.width = 40

c.height = 19000 #oh noes! Our circle became an ellipse by mistake!

puts c.circumference
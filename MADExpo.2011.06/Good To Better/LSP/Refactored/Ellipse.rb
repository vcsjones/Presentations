class Circle
  attr_accessor :radius

  def circumference
    return @radius * Math::PI
  end
end

class Ellipse < Circle
  attr_accessor :eccentricity

  def circumference
    ((0.5 * ((@radius ** 2) + (@eccentricity ** 2))) ** 0.5 * (Math::PI * 2)) / 2
  end
end

c = Ellipse.new()
c.radius = 1
c.eccentricity = 2

puts c.circumference
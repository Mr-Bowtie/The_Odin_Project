class MyCar
  attr_accessor :speed, :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0 
    @gas
  end

  def speed_up(number)
    @speed += number 
    puts "you accelerate by #{number} mph"
  end

  def brake(number)
    @speed -= number
    puts "you decelerate by #{number} mph"
  end

  def shutdown
    @speed = 0
    puts "time to park "
  end

  def current_speed
    puts "you are going #{@speed} mph"
  end

  def spray_paint(color)
    self.color = color
  end

  def gas_mileage(miles, gas_used)
    puts "You're getting #{miles / gas_used} miles per gallon"
    
  end

  def to_s
    puts "You're driving a #{year} #{color} #{@model}  "
  end
end

ranger = MyCar.new(1994, "red", "Ford Ranger")
puts ranger
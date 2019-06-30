require 'date'
module TaxDate

  def today
    Date.today
  end

  def day_of_raise_10_percent
    Date.new(2019, 10, 1)
  end

  def day_of_raise_10_percent?
    day_of_raise_10_percent > today
  end

  module_function :today, :day_of_raise_10_percent, :day_of_raise_10_percent?
end

require 'date'
module TaxDate

  def day_of_raise_10_percent?
    return true if Object.const_defined?('Settings') && Settings.row_inforced
    today >= day_of_raise_10_percent
  end

  private

  def today
    Date.today
  end

  def day_of_raise_10_percent
    Date.new(2019, 10, 1)
  end

  module_function :today, :day_of_raise_10_percent, :day_of_raise_10_percent?
end

require 'date'
class Tax

  REDUCED_RATE = 8
  NORMAL_RATE = 10
  private_constant :REDUCED_RATE, :NORMAL_RATE

  def initialize
    @rate = current_rate
    @r_rate = current_r_rate
  end

  def tax_rate
    @rate
  end

  def reduced_tax_rate
    raise UninforcedLawError unless TaxDate.day_of_raise_10_percent?
    @r_rate
  end

  private

  def current_rate
    TaxDate.day_of_raise_10_percent? ? NORMAL_RATE : REDUCED_RATE
  end

  def current_r_rate
    TaxDate.day_of_raise_10_percent? ? REDUCED_RATE : nil
  end
end

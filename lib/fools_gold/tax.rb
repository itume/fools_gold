require 'date'
class Tax

  NORMAL_RATE_BEFORE_2019_OCT = 0.08
  REDUCED_RATE_AFTER_2019_OCT = 0.08
  NORMAL_RATE_AFTER_2019_OCT = 0.1
  private_constant :NORMAL_RATE_BEFORE_2019_OCT, :REDUCED_RATE_AFTER_2019_OCT, :NORMAL_RATE_AFTER_2019_OCT

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
    TaxDate.day_of_raise_10_percent? ? NORMAL_RATE_AFTER_2019_OCT : NORMAL_RATE_BEFORE_2019_OCT
  end

  def current_r_rate
    TaxDate.day_of_raise_10_percent? ? REDUCED_RATE_AFTER_2019_OCT : nil
  end
end

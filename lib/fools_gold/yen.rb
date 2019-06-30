require 'forwardable'
require 'bigdecimal'

class Yen
  extend Forwardable

  delegate [:tax_rate, :reduced_tax_rate] => :@tax

  def initialize(num, rounding_method = :floor)
    @money = num
    @with_tax = false
    @tax = Tax.new
    @rounding_method = rounding_method
  end

  def with_tax?
    @with_tax
  end

  def with_tax!
    raise DoubleTaxaionError if @with_tax
    @with_tax = true
  end

  def with_tax
    calc_tax_included(@tax.tax_rate)
  end

  def without_tax?
    !@with_tax
  end

  def without_tax!
    raise TaxEvationError unless @with_tax
    @with_tax = false
  end

  def without_tax
    calc_tax_excluded(@tax.tax_rate)
  end

  def with_reduced_tax
    raise UninforcedLawError unless TaxDate.day_of_raise_10_percent?
    calc_tax_included(@tax.reduced_tax_rate)
  end

  def without_reduced_tax
    raise UninforcedLawError unless TaxDate.day_of_raise_10_percent?
    calc_tax_excluded(@tax.reduced_tax_rate)
  end

  private

  def calc_tax_included(tax_rate)
    return @money if @with_tax
    bd = (BigDecimal(@money) * BigDecimal((1 + tax_rate).to_s))
    rounding(bd)
  end

  def calc_tax_excluded(tax_rate)
    return @money unless @with_tax
    bd = (BigDecimal(@money) / BigDecimal((1 + tax_rate).to_s))
    rounding(bd)
  end

  def rounding(big_decimal)
    case @rounding_method
    when :floor
      big_decimal.floor.to_i
    when :ceil
      big_decimal.ceil.to_i
    when :round
      big_decimal.round.to_i
    end
  end
end

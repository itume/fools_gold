require 'forwardable'
require 'bigdecimal'

class Yen
  extend Forwardable

  delegate [:tax_rate] => :@tax

  def initialize(num)
    @money = num
    @with_tax = false
    @tax = Tax.new
  end

  def with_tax?
    @with_tax
  end

  def with_tax!
    raise DoubleTaxaionError if @with_tax
    @with_tax = true
  end

  def with_tax
    return @money if @with_tax
    (BigDecimal(@money) * BigDecimal(((100 + @tax.tax_rate) / 100.0).to_s)).to_i
  end

  def without_tax?
    !@with_tax
  end

  def without_tax!
    raise TaxEvationError unless @with_tax
    @with_tax = false
  end

  def without_tax
    return @money unless @with_tax
    (BigDecimal(@money) / BigDecimal(((100 + @tax.tax_rate) / 100.0).to_s)).to_i
  end

  def with_reduced_tax
    return @money if @with_tax
    (BigDecimal(@money) * BigDecimal(((100 + @tax.tax_rate) / 100.0).to_s)).to_i
  end
end

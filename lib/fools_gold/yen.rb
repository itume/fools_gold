require 'forwardable'
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

  def without_tax?
    !@with_tax
  end

  def without_tax!
    raise TaxEvationError unless @with_tax
    @with_tax = false
  end
end

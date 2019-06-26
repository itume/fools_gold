class Yen

  def initialize(num)
    @money = num
    @with_tax = false
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
end

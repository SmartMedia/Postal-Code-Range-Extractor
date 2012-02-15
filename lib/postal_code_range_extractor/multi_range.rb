class MultiRange
  def add(number)
    raise(ArgumentError, ':number must be in non-decreasing order') if @last_number and @last_number > number
    @last_number = number

    if range.empty? or closed?
      open!
      range << (number..number)
    else
      range[-1] = (range[-1].min..number)
    end
  end

  def close
    close!
  end

  def to_a
    range
  end

  private
  def range
    @range ||= []
  end

  def open!
    @closed = false
  end

  def close!
    @closed = true
  end

  def closed?
    @closed ||= false
  end
end

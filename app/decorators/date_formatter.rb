class DateFormatter
  def initialize(date, format=:full)
    @date = date
    @format = format || :full
  end

  def to_s
    #@date.today? ? I18n.l(@date, :format => :short) : I18n.l(@date, :format => :long)
    I18n.l(@date, :format => @format.to_sym)
  end

end
class OrganizationDecorator < Draper::Decorator
  delegate_all

  def director
    object.director.first_name_with_last_name
  end

  # отдает дату в указанном формате
  # obj.date :date_format
  def date *args
    opts = args.extract_options!
    DateFormatter.new(object.date, args.first)
  end

  def name
    'Циклон,ООО'
  end

  def director
    'Иван'
  end

  def phone
    '+7 911 918-12-45'
  end

  def path
    organization_path(object)
  end

  def edit_path
    edit_organization_path(object)
  end

end
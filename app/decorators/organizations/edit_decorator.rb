# coding: utf-8
module Organizations
  class EditDecorator < Organizations::BaseDecorator
    decorates :organization
    delegate_all

    def date_of_registration
      if object.date_of_registration
        DateFormatter.new(object.date_of_registration.try(:to_date), :full)
      end
    end

    def creation_resolution_date
      if object.creation_resolution_date
        DateFormatter.new(object.creation_resolution_date.try(:to_date), :full)
      end
    end

    def egrul_registration_date
      if object.egrul_registration_date
        DateFormatter.new(object.egrul_registration_date.try(:to_date), :full)
      end
    end
  end
end
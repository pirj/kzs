module Documents
  class StateDecorator < Draper::Decorator
    delegate_all
    decorates :document

    def current_humanize_state
      humanize_state accountable.current_state
    end

    def humanize_state state
      translates_state 'state', state
    end

    def to_humanize_state state
      translates_state 'to_state', state
    end

    def current_state
      accountable.current_state
    end


    protected

    def translates_state scope, state
      prefix = accountable.class.to_s.underscore
      I18n.t("activerecord.document.#{prefix}.#{scope}.#{state}")
    end

    # return Documents::Order class (or Report, or Mail)
    def accountable
      _doc = object.respond_to?(:object) ? object.object : object # if decorates object was decorated
      @_state_decorator_accountable ||= _doc.respond_to?(:document) ? _doc : _doc.accountable
    end

  end
end
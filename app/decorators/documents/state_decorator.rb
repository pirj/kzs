module Documents
  class StateDecorator < Draper::Decorator
    delegate_all
    decorates :document

    # translating current state in 'now state' style
    def current_humanize_state
      humanize_state accountable.current_state
    end

    # translating state name in 'now state' style
    def humanize_state state
      translates_state 'state', state
    end

    # translating state name in 'next state' style
    def to_humanize_state state
      translates_state 'to_state', state
    end

    # not-translated current state
    def current_state
      accountable.current_state
    end

    # return css class name for current state
    def css_class_for_current_state
      css_class_for current_state
    end

    # return css class name for different states
    def css_class_for state
      css_class = 'primary'
      css_class = case current_state.to_sym
                    when :draft then 'default'
                    when :prepared then 'primary'
                    when :approved then 'success'
                    when :sent_sender then 'warning'
                    when :sent_recipient then 'warning'
                    when :read then 'warning'
                    when :trashed then 'danger'
                    else 'default'
                  end
      css_class
    end


    protected

    # return translated for state and state-action from locale.yml
    def translates_state scope, state
      prefix = accountable.class.to_s.underscore
      I18n.t("activerecord.document.#{prefix}.#{scope}.#{state}#{state_postfix}")
    end

    # return Documents::Order class (or Report, or Mail)
    def accountable
      _doc = object.respond_to?(:object) ? object.object : object # if decorates object was decorated
      @_state_decorator_accountable ||= _doc.respond_to?(:document) ? _doc : _doc.accountable
    end

    # some extra translates for sender and recipients user roles
    def state_postfix
      if current_state.to_sym == :sent
        if h.current_user.organization == accountable.sender_organization
          '_sender'
        elsif h.current_user.organization == accountable.recipient_organization
          '_recipient'
        else
          ''
        end
      end
    end

    #model_scope = object.accountable_type.downcase.gsub('documents::','')
    #
    #state = if object.state == 'sent' && object.read_at != nil
    #          'read'
    #        elsif object.state == 'sent' && object.read_at == nil
    #          (object.sender_organization.id == h.current_user.organization_id) ? 'sent_sender' : 'sent_recipient'
    #        else
    #          object.state
    #        end


  end
end
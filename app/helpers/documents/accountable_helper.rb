module Documents::AccountableHelper
  # TODO: remove this all and make allowed_transitions return proper values
  def submittable_transitions(accountable)
    states = accountable.allowed_transitions
    states = states - %w(trashed) if accountable.new_record?
    states
  end

end
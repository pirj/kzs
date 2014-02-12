module Documents::StateMachine
  def applicable_states
    @applicable_states ||= self.class.states.select{|state| can_transition_to?(state)}
  end
end
module Documents::StateMachine
  def applicable_states
    @applicable_states ||= self.class.successors[self.current_state]
  end
end
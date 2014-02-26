module Documents::AccountableHelper
  # TODO: @prikha it might have been put into form_helpers.
  # Submit button can have content.

  def submit_accountable(state, options={})
    submit_options = { name: 'transition_to', value: state, class: 'btn btn-default' }
    submit_options.merge!(options)
    submit_button(submit_options) do
      t("helpers.submit.documents.to.#{state}")
    end
  end


  def submit_button(options, &block)
    options.reverse_merge!(type: 'submit')
    button_tag(options, &block)
  end
end
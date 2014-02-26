module Documents::AccountableHelper
  # TODO: @prikha it might have been put into form_helpers.
  # Submit button can have content.
  def button_with_content(content, options)
    content_tag(:button, content, options )
  end

  def submit_accountable(state, html_class = 'btn-primary')
    button_with_content(t("helpers.submit.documents.to.#{state}"), name: 'transition_to', type: 'submit', value: state, class: "btn #{html_class}")
  end
end
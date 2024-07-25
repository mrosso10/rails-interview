# frozen_string_literal: true

class LinkComponentPreview < ViewComponent::Preview
  def default
    render(LinkComponent.new(text: 'text', target: 'javascript:void(0)'))
  end
end

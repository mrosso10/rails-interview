# frozen_string_literal: true

class LinkComponent < ViewComponent::Base
  BUTTON_CLASS = 'inline-block rounded py-2 px-3 text-white font-medium'

  def initialize(text:, target:, type: :primary, method: :get)
    @text = text
    @target = target
    @type = type
    @method = method

    super
  end

  def call
    link_to @text, @target, 'data-turbo-method': @method, class: "#{BUTTON_CLASS} #{background_color}"
  end

  private

  def background_color
    {
      primary: 'bg-blue-900',
      secondary: 'bg-gray-800',
      danger: 'bg-red-800'
    }[@type]
  end
end

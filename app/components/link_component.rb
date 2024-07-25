# frozen_string_literal: true

class LinkComponent < ViewComponent::Base
  BUTTON_CLASS = 'inline-block rounded py-2 px-3 text-white font-medium'

  def initialize(
    text:,
    target:,
    type: :primary,
    method: :get,
    turbo_stream: false
  )
    @text = text
    @target = target
    @type = type
    @method = method
    @turbo_stream = turbo_stream

    super
  end

  def call
    options = {
      'data-turbo-method': @method,
      class: "#{BUTTON_CLASS} #{background_color}"
    }
    options[:'data-turbo-stream'] = true if @turbo_stream
    link_to @text, @target, options
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

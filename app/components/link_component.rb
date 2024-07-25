# frozen_string_literal: true

class LinkComponent < ViewComponent::Base
  BUTTON_CLASS = 'inline-block rounded py-2 font-medium hover:cursor-pointer'

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
      class: "#{BUTTON_CLASS} #{fg_color}"
    }
    options[:'data-turbo-stream'] = true if @turbo_stream
    link_to @text, @target, options
  end

  private

  def fg_color
    {
      primary: 'text-slate-600 hover:text-blue-700',
      secondary: 'text-slate-600 hover:text-slate-700',
      danger: 'text-slate-600 hover:text-red-700',
      link: 'text-blue-800',
      link_danger: 'text-red-800'
    }[@type]
  end
end

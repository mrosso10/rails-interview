# frozen_string_literal: true

class AlertComponent < ViewComponent::Base
  def initialize(title: nil, description: nil)
    @title = title
    @description = description
    super
  end
end

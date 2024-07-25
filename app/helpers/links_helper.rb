module LinksHelper
  def link(text, target, type: :primary)
    render LinkComponent.new(text:, target:, type:)
  end

  def link_delete(text, target, type: :danger)
    render LinkComponent.new(text:, target:, type:, method: :delete)
  end
end

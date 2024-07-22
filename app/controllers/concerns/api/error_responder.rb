module Api
  module ErrorResponder
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    end

    def record_invalid(exception)
      render json: { errors: exception.record.errors }, status: :unprocessable_entity
    end
  end
end

module Api
  module ErrorResponder
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
    end

    def record_invalid(exception)
      render json: { errors: exception.record.errors }, status: :unprocessable_entity
    end

    def not_found
      head :not_found
    end
  end
end

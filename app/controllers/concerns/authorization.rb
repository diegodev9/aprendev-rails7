module Authorization
  extend ActiveSupport::Concern

  included do
    class NotAuthorizedError < StandardError; end
    rescue_from NotAuthorizedError do
      redirect_to products_path, alert: t('common.not_authorized')
    end

    private

    def authorize!(record = nil)
      is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(record).send(action_name)

      raise NotAuthorizedError unless is_allowed # detiene toda la logica que sigue
      # redirect_to products_path, alert: t('common.not_authorized') unless is_allowed # estaba funcionando bien pero se comenta segun video del curso
    end
  end
end
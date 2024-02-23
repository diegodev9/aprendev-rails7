class CategoryPolicy < BasePolicy
  private def method_missing(m, *args, &block)
    Current.user.admin?
  end
end
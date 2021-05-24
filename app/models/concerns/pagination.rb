module Concerns::Pagination
  def self.included(base)
    base.class_eval do
      extend ClassMethods
    end
  end

  module ClassMethods
    def paginate(params)
      params[:page].to_i > 1 ? offset = params[:page].to_i : offset = 1
      params[:per_page] ? limit = params[:per_page].to_i : limit = 20
      self.limit(limit).offset((offset-1) * 20)
    end

    # private

    # def set_limit(params)
    #   [
    #     params.fetch(:per_page, 100).to_i,
    #     100
    #   ].min
    # end
  end
end
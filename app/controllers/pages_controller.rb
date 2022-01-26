class PagesController < ApplicationController
  def home
    @featured = Product.where(['featured = ?', true]).first
    @recent_wines = Product.wines.order('created_at DESC').limit(5)
  end

  def retail_partnership; end
end

# frozen_string_literal: true

# ApplicationHelper contains some helper methods for application
module ApplicationHelper
  def sortable(column, title = nil)
    order = 'asc'
    if %w[asc desc].include?(params[:order])
      order = params[:order] == 'desc' ? 'asc' : 'desc'
    elsif %w[asc desc].include?(session[:order])
      order = session[:order]
      if column == session[:key]
        order = order == 'desc' ? 'asc' : 'desc'
      end
    end
    title ||= column.titleize
    title += if order == 'asc'
               '⬆️'
             else
               '⬇️'
             end

    link_to title, { key: column, order: }
  end
end

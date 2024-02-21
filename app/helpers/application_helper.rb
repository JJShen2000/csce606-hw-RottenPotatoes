# frozen_string_literal: true

# ApplicationHelper contains some helper methods for application
module ApplicationHelper
  def sortable(column, title = nil)
    order = 'asc'
    if (params[:key] == column || session[:key] == column) && params[:order].presence
      order = params[:order] == 'desc' ? 'asc' : 'desc'
    elsif (params[:key] == column || session[:key] == column) && session[:order].presence
      order = session[:order]
      if column == session[:key]
        order = session[:order] == 'desc' ? 'asc' : 'desc'
      end
    end
    title ||= column.titleize
    if params[:key] == column || session[:key] == column
      title += if order == 'asc'
                 '⬆️'
               else
                 '⬇️'
               end
    end

    button_to(title, { key: column, order: order }, method: :get, params: { key: column, order: order })
  end

  def column_class(column)
    column == params[:key] || column == session[:key] ? 'key_column' : 'default_column'
  end
end

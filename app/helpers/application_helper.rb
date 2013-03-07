module ApplicationHelper
  def sortable(column, params, title = nil)
  title ||= column.titleize
  css_class = column == University.sort_column(params) ? "current #{University.sort_direction(params)}" : nil
  direction = column == University.sort_column(params) && University.sort_direction(params) == "desc" ? "asc" : "desc"
  link_to title, {:sort => column, :direction => direction, :state => params[:state], :query => params[:query]}, {:class => css_class}
  end
end

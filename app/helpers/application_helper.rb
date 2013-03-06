module ApplicationHelper
  def sortable(column, title = nil, state = nil)
  title ||= column.titleize
  css_class = column == sort_column ? "current #{sort_direction}" : nil
  direction = column == sort_column && sort_direction == "desc" ? "asc" : "desc"
  link_to title, {:sort => column, :direction => direction, :state => state}, {:class => css_class}
  end
end

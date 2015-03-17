# Helper for the application
module ApplicationHelper
  def full_title(title)
    return 'Accounty' if title.empty?
    "#{title} | Accounty"
  end
end

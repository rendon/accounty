# Helper for the application
module ApplicationHelper
  def full_title(title)
    return 'Accounty' if title.empty?
    "#{title} | Accounty"
  end

  def str_to_date(date)
    tokens = date.split('/')
    year = tokens[0].to_i
    month = tokens[1].to_i
    day = tokens[2].to_i
    Date.new(year, month, day)
  end

  def date_to_str(date)
    "#{date.year}/#{date.month}/#{date.day}"
  end
end

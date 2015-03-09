module NavigationHelper
  def path_to(page)
    case page
    when 'home'
      '/'

    when 'help'
      '/help'

    when 'about'
      '/about'

    when 'sign up'
      '/signup'

    when 'login'
      '/login'
    end
  end
end

World(NavigationHelper)

module ApplicationHelper
  def search(&block)
    render('layouts/search', content: capture(&block))
  end

  def active_link controller
     'active' if controller_name == controller    
  end
end

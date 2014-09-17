module StaticPagesHelper
  def full_title(title)
    base_title = "Ruby on Rails tutorial"
    if title.empty?
      base_title
    else
      "#{base_title} | #{title}"
    end    
  end

end

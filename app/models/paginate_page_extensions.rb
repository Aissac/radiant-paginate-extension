module PaginatePageExtensions
  def self.included(base)
    base.send(:include, PaginateTags)
    base.class_eval do
      alias_method_chain :find_by_url, :paginate
    end
  end
  
  def find_by_url_with_paginate(url, live = true, clean = true)
    @paginate_url_route ||= Radiant::Config['paginate.url_route']
    url = clean_url(url) if clean
    
    if url =~ %r{^#{ self.url }#{@paginate_url_route}\d+\/$}
      self
    else
      find_by_url_without_paginate(url, live, clean)
    end
  end
  
end

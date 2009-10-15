class PaginateExtension < Radiant::Extension
  version "1.0"
  description "Pagination with will_paginate"
  url "http://blog.aissac.ro/radiant/paginate-extension/"
  
  def activate 
    if Radiant::Config.table_exists?
      Radiant::Config['paginate.url_route'] = '' unless Radiant::Config['paginate.url_route']
      PaginateExtension.const_set('UrlCache', Radiant::Config['paginate.url_route'])
    end
    Page.send(:include, PaginateTags)
    Page.send(:include, PaginatePageExtensions)
  end
  
  def deactivate
  end
end
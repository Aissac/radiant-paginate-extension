# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class PaginateExtension < Radiant::Extension
  version "1.0"
  description "Pagination with will_paginate"
  url "http://github.com/Aissac/radiant-paginate-extension"
  
  @@url_cache = ''
  cattr_accessor :url_cache
  
  def activate
    if ActiveRecord::Base.connection.tables.include?('config')
      Radiant::Config['paginate.url_route'] = '' unless Radiant::Config['paginate.url_route']
      url_cache = Radiant::Config['paginate.url_route']
    end
    Page.send(:include, PaginatePageExtensions)
  end
  
  def deactivate
  end
  
end
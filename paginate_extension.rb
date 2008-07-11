# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class PaginateExtension < Radiant::Extension
  version "1.0"
  description "Pagination with will_paginate"
  url "http://github.com/ihoka/radiant-paginate-extension"
  
  def activate
    PaginatePage
  end
  
  def deactivate
  end
  
end
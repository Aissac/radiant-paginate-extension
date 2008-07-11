module PaginateTags
  include Radiant::Taggable
  include WillPaginate::ViewHelpers
  
  class RadiantLinkRenderer < WillPaginate::LinkRenderer
    def initialize(tag)
      @tag = tag
    end
    
    def page_link(page, text, attributes = {})
      %Q{<a href="#{@tag.locals.page.url}#{page}">#{text}</a>}
    end

    def page_span(page, text, attributes = {})
      "<span class=\"page\">#{text}</span>"
    end
  end
  
  desc %Q{
    Wrapper for pagination content. <r:paginate:each> and <r:paginate:pages> must be nested inside.
    
    Usage:
    <pre><code>
    <r:paginate [per_page="10"] [order="asc|desc"] [by="attribute"]>
      ...
      <r:each>...</r:each>
      ...
      <r:pages />
    </r:paginate>
    </code></pre>
  }
  tag 'paginate' do |tag|
    tag.locals.previous_headers = {}
    
    options = paginate_find_options(tag)
    
    paginated_children = tag.locals.page.children.paginate(options)
    tag.locals.paginated_children = paginated_children
    
    tag.expand
  end
  
  desc %Q{
    Renders nested content for each child of current page. Must be placed inside <r:paginate>
    
    Usage:
    <pre><code>
    <r:paginate>
      <r:each>
        <r:link />
      </r:each>
    </r:paginate>
    </code></pre>
  }
  tag 'paginate:each' do |tag|
    result = []
    
    tag.locals.paginated_children.each do |item|
      tag.locals.child = item
      tag.locals.page = item
      result << tag.expand
    end
    result
  end
  
  desc %Q{
    Renders pagination links with will_paginate.
  }
  tag 'paginate:pages' do |tag|
    renderer = RadiantLinkRenderer.new(tag)
    will_paginate tag.locals.paginated_children, :renderer => renderer, :container => false
  end
  
  private
    def paginate_find_options(tag)
      attr = tag.attr.symbolize_keys
      
      options = {}
      
      options[:page] = tag.attr['page'] || @request.path[/^#{Regexp.quote(tag.locals.page.url)}(\d+)\/?$/, 1]
      options[:per_page] = tag.attr['per_page'] || 10
      
      by = (attr[:by] || 'published_at').strip
      order = (attr[:order] || 'asc').strip
      order_string = ''
      if self.attributes.keys.include?(by)
        order_string << by
      else
        raise TagError.new("`by' attribute of `each' tag must be set to a valid field name")
      end
      if order =~ /^(asc|desc)$/i
        order_string << " #{$1.upcase}"
      else
        raise TagError.new(%{`order' attribute of `each' tag must be set to either "asc" or "desc"})
      end
      options[:order] = order_string
      
      options
    end
end
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
    
    parents = paginate_find_parent_pages(tag)
    options = paginate_find_options(tag)
    
    paginated_children = Page.paginate(options.merge(:conditions => ["pages.parent_id in (?) AND virtual='f'", parents]))
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
    Expands when this is the first child in paginate:each
  }
  tag 'paginate:each:if_first' do |tag|
    tag.expand if tag.locals.index == 0
  end
  
  desc %Q{
    Expands unless this is the first child in paginate:each
  }
  tag 'paginate:each:unless_first' do |tag|
    tag.expand unless tag.locals.index == 0
  end
  
  desc %Q{
    Renders pagination links with will_paginate.
  }
  tag 'paginate:pages' do |tag|
    renderer = RadiantLinkRenderer.new(tag)
    
    options = {}
    
    [:class, :prev_label, :next_label, :inner_window, :outer_window, :separator].each do |a|
      options[a] = tag.attr[a.to_s] unless tag.attr[a.to_s].blank?
    end
    options[:page_links] = false if 'false' == tag.attr['page_links']
    
    will_paginate tag.locals.paginated_children, options.merge(:renderer => renderer, :container => false)
  end
  
  private
    def paginate_find_parent_pages(tag)
      attr = tag.attr.symbolize_keys
      
      level = (attr[:level] || '1').to_i
      page = attr[:url] && Page.find_by_url(attr[:url]) || tag.locals.page
      
      if level == 2
        page.children.map(&:id)
      else
        [page.id]
      end
    end
  
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
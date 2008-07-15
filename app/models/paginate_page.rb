class PaginatePage < Page
  include PaginateTags

  description %{ Create a page that allows pagination of children. }
  
  def find_by_url(url, live = true, clean = true)
    url = clean_url(url) if clean
    
    if url =~ %r{^#{ self.url }\d+\/}
      self
    else
      super
    end
  end
  
end

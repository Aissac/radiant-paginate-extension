require File.dirname(__FILE__) + '/../spec_helper'

describe "Paginate Tags" do
  
  dataset :pages
  
  before do
    @page = pages(:news)
  end
  
  describe "<r:paginate:each />" do
    
    it "renders the paginated children of the current pages" do
      @page.should 
        render("<r:paginate per_page='2'><r:each><r:title /> </r:each></r:paginate>").
        as("Article Article 2 ")
    end
    
    it "changes the sort order when given the order attribute" do
      @page.should 
        render("<r:paginate per_page='2' order='desc'><r:each><r:title /> </r:each></r:paginate>").
        as("Article 4 Article 3 ")
    end
    
    it "sorts by the given attribute" do
      @page.should
        render("<r:paginate per_page='2' by='title'><r:each><r:title /> </r:each></r:paginate>").
        as("Article Article 2 ")
    end
    
    it "sort by the 'by' attribute according to the 'order' attribute" do
      @page.should
        render("<r:paginate per_page='2' by='title' order='desc'><r:each><r:title /> </r:each></r:paginate>").
        as("Article 4 Article 3 ")
    end
  end
  
  describe "<r:paginate:each:if_first /> and <r:paginate:each:unless_first />" do
    
    it "renders the contained block if the child is first" do
      @page.should 
        render("<r:paginate per_page='2'><r:each><r:if_first><r:title/></r:if_first></r:each></r:paginate>").
        as("Article")
    end
    
    it "renders the contained block if the child is not the first" do
      @page.should 
        render("<r:paginate per_page='2'><r:each><r:unless_first><r:title/></r:unless_first></r:each></r:paginate>").
        as("Article 2")
    end
  end
  
  describe "<r:paginate:pages />" do
    
    it "renders pagination links" do
      @page.should 
        render("<r:paginate per_page='2'><r:pages /></r:paginate>").
        as("<span class=\"disabled prev_page\">&laquo; Previous</span> <span class=\"current\">1</span> <a href=\"/news/2\" rel=\"next\">2</a> <a href=\"/news/2\" class=\"next_page\" rel=\"next\">Next &raquo;</a>")
    end
  end
end
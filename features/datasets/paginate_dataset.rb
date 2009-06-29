class PaginateDataset < Dataset::Base
  
  uses :pages
  
  def load
    create_page "To Paginate", 
      :slug => "to-paginate",
      :body => %Q{
        <r:paginate per_page='2' order='asc' by='title'>
          <r:each>
            <r:link />
          </r:each>
          <r:pages />
        </r:paginate>} do
      create_page "Child 1 (one)"
      create_page "Child 2 (two)"
      create_page "Child 3 (three)"
      create_page "Child 4 (four)"
      create_page "Child 5 (five)"
      create_page "Child 6 (six)"
      create_page "Child 7 (seven)"
    end
  end
  
end
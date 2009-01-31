Be sure to set `Radiant::Config['paginate.url_route']` to something 
or your archived pages urls may not be processed properly.

Without that setting, your paginated pages will be found at 

        /my_pages
    /my_pages/2
    /my_pages/3
    
This may cause problems with archived pages which may be found at

        /articles/2009
    
Instead, you should set your `paginate.url_route` to something like
`page-` so that your paginated pages appear in the urls

        /my_pages
    /my_pages/page-2
    /my_pages/page-3
Radiant Paginate Extension
===

About
---
An extension by [Aissac][ai] that provides pagination support to [Radiant CMS][rd].

Tested on Radiant 0.7.1 and 0.8.

Features
---

Uses will_paginate plugin to iterate over children of a Page with pagination options:
* Specify number children per page
* Ordering by a specific page attribute and order direction
* Conditionally render content for first page
* Render pagination links customizable from the Radius tag (specify next/prev label, DOM class, inner and outer window etc.)

Installation
---

The [Radiant Paginate Extension][rpe] has one dependency: the 'will_paginate' gem/plugin

    git submodule add git://github.com/mislav/will_paginate.git\
      vendor/plugins/will_paginate
    
or

    sudo gem install mislav-will_paginate --source http://gems.github.com

Then install the [Radiant Paginate Extension][rpe]:

    git submodule add git://github.com/Aissac/radiant-paginate-extension.git\
      vendor/plugins/paginate

Configuration
---
Because the archived pages urls may not be processed properly, it is recommended to set `Radiant::Config['paginate.url_route']` to something like `page-`

Usage
---

###Available Tags
* See the "available tags" documentation built into the Radiant page admin for more details.
* Use the `<r:paginate:each> /` to render the content for each child of the current page.
* Use the `<r:paginate:each:if_first />` to expand when this is the first child
* Use the `<r:paginate:each:unless_first />` to expand when this is not the first child
* Use the `<r:paginate:pages />` to render the pagination links with `will_paginate`.

Contributors
---

* Istan Hoka
* Benny Degezelle
* Jim Gay
* Andrew Neil
* Michael Kessler
* Cristi Duma

[ai]: http://www.aissac.ro/
[rd]: http://radiantcms.org/
[rpe]: http://blog.aissac.ro/radiant/paginate-extension/
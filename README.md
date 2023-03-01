# Personal financial manager
### Course project by Vladislav Roschupkin
<p>
Course project made after the course "Розробка вебдодатків на Ruby від SoftServe" on the platform "PROMETHEUS"
</p>


### The functional that is in the project:
* Simple User Registration/Authorization mechanism
* Categories:
  + Add category
  + Edit category
  + Delete category
  + Search category
  + Show operation
* Operations:
  + Add operation
  + Edit operation
  + Delete operation
* Pagination
* Generate graphic:
  + graphic by dates - Generates a curve line graph for the selected category between two dates
  + graphic by categories - Creates a pie chart, selects all transactions and builds it by the amount accrued/received between two dates
  + graphic on main page by categories - Creates a pie chart, selects all expenses and builds it by the amount accrued for that month
  + graphic on main page by dates - Generates a curve line graph, selects all operation and builds it by the amount accrued for that month
* A simple mechanism for changing the language:
  + en
  + ua
  + ru
  
### Used gems:
<p>pagy - gem for create simple pagination on page</p>
<p>chartkick - gem for intigrate chartjs library to rails app</p>
<p>groupdate - gem for grouping information from db or arrays, used for grop data to graphics</p>
<p>rails-i18n - gem for create localiztion in app</p>

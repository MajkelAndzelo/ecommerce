# My first ecommerce app!

I created a Ruby on Rails ecommerce project that utilizes Postgresql as its database management system. The project allows users to sign up and sign in with a unique nickname, and they can create their product listings, edit and delete only their own listings. Users can also change their email, password, and nickname on the "edit profile" page. They can also add products to their cart and buy them in any quantity they desire.

As an admin, I have the ability to perform all the user actions, and I can delete any product listing. I can also create, edit, and delete categories. On the "edit profile" page, I can see that I am an admin.

The products on the platform have a name, image, price, category, and description. They can be purchased by users in any quantity, and after a user buys a product, the system will ask for the quantity desired. The product owners can create, edit, and delete their own products, and the admin has the ability to delete any product. Each product is associated with a category, and the categories are shown on their own page.

The cart system allows users to store products that they want to buy along with their quantity. They can also delete products from their cart and change their quantity. The cart has a checkout button, which redirects the user to the checkout page.

The project's visual representation is created using Bootstrap. The navbar is included in the shared folder to avoid messing up the layout/application.html.erb. The navbar includes links for signing up, signing in, and editing profiles. The project also uses flash alerts, which are also included in the shared folder, to display success or error messages.

The root page of the project is the product's page, which displays all the products in bootstrap cards. Each card includes the product's name, image, price, category, and description. The card also includes a button to buy the product. Product owners and admins have the ability to edit or delete the product.

The categories page includes a list of categories, which are displayed as links and buttons. Only admins have the ability to create, edit, and delete categories. The page also includes a button to create a new category.

Overall, my project allows users to create, buy, and manage their product listings, while the admin can manage the products and categories on the platform. The visual representation of the project is clean and easy to navigate, thanks to the use of Bootstrap.
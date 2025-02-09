class StaticPagesController < ApplicationController
  def pricing
    # Add pricing content here
  end

  def about
    # Add "About Us" content here
  end

  def blog
    # Add blog listing or links here
  end

  def contact
    # Add contact information or a contact form here
  end

  def terms
    # Add terms of service content here
  end

  def search
    # Implement search functionality here.
    # For now, you can simply display the search query:
    @query = params[:q]
  end
end

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

  def send_message
    name = params[:name]
    email = params[:email]
    message = params[:message]

    # Send the email
    ContactMailer.send_contact_email(name, email, message).deliver_now

    flash[:notice] = "Thank you, #{name}! Your message has been sent."
    redirect_to contact_path
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

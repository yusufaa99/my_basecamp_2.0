# Welcome to My Basecamp 2
***

## Task
The Problem
Managing users, authentication, and permissions in a web application can be complex. Many applications require role-based access control, user dashboards, and profile management. Without a structured system, security vulnerabilities and inefficiencies can arise.

The Challenge
User Authentication: Implementing a secure and scalable authentication system.
Role Management: Defining admin and regular user roles with proper permissions.
Dashboard Navigation: Ensuring users land on the correct page based on their roles.
Profile Management: Allowing users to edit their personal information.
User Deletion: Providing admins with control over user accounts.
Database Integrity: Maintaining consistency when users are modified or removed.

This project solves these challenges using Ruby on Rails with Devise for authentication, ensuring a structured and secure user management system.

## Description
How Have We Solved the Problem?
To address the challenges of user authentication, role management, and dashboard navigation, we implemented the following solutions using Ruby on Rails and Devise:

1. User Authentication (Devise)
Integrated Devise for secure user authentication (login, signup, logout, password recovery).
Added email-based authentication with encrypted passwords.
Implemented session management to track logged-in users.
2. Role-Based Access Control (RBAC)
Modified the User model to include an admin boolean field.
Restricted certain actions (e.g., user deletion) to admin users only.
Used before_action filters to enforce role-based permissions.
3. User Dashboard
Redirected logged-in users to a personalized dashboard upon login.
Displayed user-specific information, such as their name and profile details.
Ensured admin users have a different dashboard with additional management tools.
4. Profile Management
Enabled users to edit their profile (name, email, profile Bio).
Used Strong Parameters to protect user data from unauthorized updates.
Validated form inputs for security and consistency.
5. User Deletion (Admin Only)
Created a user management panel for admins.
Allowed admins to delete users via a destroy action in UsersController.
Ensured proper data cleanup when a user is removed.
6. Database Integrity & Migrations
Used Rails migrations to add necessary fields to the users table.
Ensured data integrity using validations and constraints in the model.
Implemented proper associations to maintain relationships between users and other entities.
7. Frontend & UI Enhancements
Designed clean and intuitive views using Rails' ERB templates.
Styled forms and dashboards using Bootstrap for a modern look.
Added flash messages to provide real-time user feedback.

Outcome
With these implementations, we now have a secure, scalable, and user-friendly system that effectively manages authentication, user roles, and profiles while maintaining database integrity.

## Installation
How to Install the Project?
Follow these steps to set up and run the project on your local machine.

1. Prerequisites
Make sure you have the following installed:

Ruby (>= 3.0) → Download Ruby
Rails (>= 7.0) → Install using:

gem install rails
Bundler → Install using:
$> gem install bundler
PostgreSQL
Node.js & Yarn → Required for managing assets

$> npm install -g yarn

2. Clone the Repository
$> git clone https://github.com/yourusername/my_basecamp_2.git OR git clone https://gitea.com/yourusername/my_basecamp_2.git
$> cd my_basecamp_2

3. Install Dependencies
$> bundle install
$> yarn install

4. Database Setup
Run the following commands to set up the database:
$> rails db:create  
$> rails db:migrate  
$> rails db:seed  # For Creation of Sole Admin not a Project Admin (Project Creator/Owner)

5. Start the Rails Server
Run the Rails server to start the application:
$> rails server
By default, the app will be available at http://localhost:3000

6. Access the Application
Signup/Login using Devise authentication.
Admins can manage users from the admin panel.
Regular Users are redirected to their dashboard.

## Usage
How Does It Work?
Once the project is set up and running, users can interact with the application based on their roles and permissions.

1. User Authentication
The application uses Devise for authentication.
Users can sign up, log in, and log out securely.
Password recovery and email confirmation features are available (if configured).
2. User Roles & Permissions
I have two types of Admins [Sole Admin(user.admin) and Project Admin(project.creator)]
Admin Users have full access to manage other users.
Regular Users have access to their personal dashboard.
Role-based access control is implemented to restrict unauthorized actions.
3. Navigating the Application
Home Page (Public)
The landing page welcomes visitors and provides login/signup options.
User Dashboard (Authenticated Users)
After logging in, users are redirected to their dashboard.
They can view and manage their profile (edit name, email, profile bio, etc.).
Any personalized content or user-specific features will be displayed here.
Admin Panel (For Admins Only)
Admins can view a list of all users.
They can edit or delete user accounts as needed.
4. Logging Out
Users can log out anytime using the "Log Out" button, which redirects them back to the home page.

5. Running the Application Locally
To start the Rails server and access the app:
```
$> rails server
```

### The Core Team
Programmer: Matthew Prince Emmanuel


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span>

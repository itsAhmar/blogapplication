BLOG Application
Description
BLOG Application is a full-stack Ruby on Rails (RoR) application developed as a beginner's project in RoR. The application allows users to sign up, create posts, view other users' posts, comment on posts, and like both posts and comments. It utilizes various Ruby gems for functionality and Bootstrap for styling. Additionally, Stimulus.js is integrated for dynamic frontend interactions. Future plans include improving the UI and implementing additional features.

Features
User Authentication: Utilizes Devise gem for user authentication.
Post Creation: Users can create their posts to share with the community.
Post Viewing: Allows users to view posts created by others.
Commenting: Users can comment on posts to engage in discussions.
Liking: Provides the functionality for users to like both posts and comments.
Installation
Clone the repository to your local machine.
bash
Copy code
git clone <repository-url>
Install dependencies using Bundler.
bash
Copy code
bundle install
Set up the database.
bash
Copy code
rails db:create
rails db:migrate
Start the Rails server.
bash
Copy code
rails server
Visit http://localhost:3000 in your web browser to access the application.
Technologies Used
Ruby on Rails
Devise
Pagy
Bootstrap
Stimulus.js
Future Enhancements
Improve UI/UX design.
Implement additional features to enhance user experience.
Contributing
Contributions are welcome! Feel free to open an issue or submit a pull request.

License
This project is licensed under the MIT License.

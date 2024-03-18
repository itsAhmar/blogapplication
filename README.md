
# BLOG Application

BLOG Application is a full-stack Ruby on Rails (RoR) application developed as a beginner's project in RoR. It utilizes various Ruby gems for functionality and Bootstrap for styling. Additionally, Stimulus.js is integrated for dynamic frontend interactions. Future plans include improving the UI and implementing additional features.




## Features

- **User Authentication:** Utilizes Devise gem for user authentication.
- **Post Creation:** Users can create their posts to share with the community.
- **Post Viewing:** Allows users to view posts created by others.
- **Commenting:** Users can comment on posts to engage in discussions.
- **Liking:** Provides the functionality for users to like both posts and comments.


## Tech Stack

**Client:** HTML, Bootstrap and Stimulus Js

**Server:** Rails, Hotwire and turbo


## Installation

Clone the repository to your local machine
   ```bash
   git clone https://github.com/itsAhmar/blogapplication
```
Install dependencies using Bundler
```bash
bundle install
```
Set up the database
```bash
rails db:create
rails db:migrate
```
Start the Rails server
```bash
rails server
```
Visit http://localhost:3000 in your web browser to access the application

## Contributing
Contributions are welcome! Feel free to open an issue or submit a pull request.


## License


This project is licensed under the [MIT](https://choosealicense.com/licenses/mit/)
 License.

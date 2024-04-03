//posts list link (root path) | link to create new post(post form)

import { Link } from "react-router-dom";

export default function NavBar() {
  return (
    <nav>
        <Link to="/">Posts List</Link>
        {" | "}
        <Link to="/posts/new">New Post</Link>
    </nav>
  )
}

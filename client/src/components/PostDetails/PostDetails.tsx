import React, { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { API_URL } from "../../constants";

interface Post {
  id: number;
  title: string;
  description: string;
}

function PostDetails() {
  const [post, setPost] = useState<Post | null>();
  const { id } = useParams<{ id: string }>();

  useEffect(() => {
    async function fetchCurrentPost() {
      try {
        const response = await fetch(`${API_URL}/${id}`);
        if (response.ok) {
          const res = await response.json()
          setPost(res);
          console.log('id:- ', res.id)
        } else {
          throw new Error("Failed to fetch data");
        }
        } catch (e) {
          console.error("Error:", e);
        }
    }
    fetchCurrentPost();
  }, [id]);

  if (!post) return <h2>Loading...</h2>;

  return (
    <div>
      <h2>Title: {post.title}</h2>
      <p>Description: {post.description}</p>
      <Link to="/">Back to Posts</Link>
    </div>
  );
}

export default PostDetails;

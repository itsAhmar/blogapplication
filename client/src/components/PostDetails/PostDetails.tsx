import React, { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { API_URL } from "../../constants";

interface Post {
  id: number;
  title: string;
  body: string;
}

function PostDetails() {
  const [post, setPost] = useState<Post | null>(null);
  const { id } = useParams<{ id: string }>();

  useEffect(() => {
    async function fetchCurrentPost() {
      try {
        const response = await fetch(`${API_URL}/${id}`);
        if (response.ok) {
          const json = await response.json();
          setPost(json);
        } else {
          throw new Error("Failed to fetch data");
        }
      } catch (e) {
        console.error("Error:", e);
      }
    }
    debugger
    if (id && parseInt(id) !== post?.id) {
      fetchCurrentPost();
    }
  }, [id]);

  if (!post) return <h2>Loading...</h2>;

  return (
    <div>
      <h2>{post.title}</h2>
      <p>{post.body}</p>
      <Link to="/">Back to Posts</Link>
    </div>
  );
}

export default PostDetails;

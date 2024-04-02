import React, { useEffect, useState } from "react";
import { API_URL } from "../../constants";

interface Post {
  id: number;
  title: string;
  description: string;
  image_url: string;
}

function PostList() {
  const [posts, setPosts] = useState<Post[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function loadPosts() {
      try {
        const response = await fetch(API_URL);
        if (response.ok) {
          const json: Post[] = await response.json();
          setPosts(json);
        } else {
          throw new Error("Failed to fetch data");
        }
      } catch (e) {
        setError("Error");
      } finally {
        setLoading(false);
      }
    }
    loadPosts();
  }, []);

  return (
    <div>
      {loading ? (
        <div>Loading...</div>
      ) : error ? (
        <div>Error: {error}</div>
      ) : (
        posts.map((post) => (
          <div key={post.id} className="post-container">
            {post.image_url && <img src={post.image_url} alt={post.title} />}
            <h2>{post.title}</h2>
            <p>{post.description}</p>
          </div>
        ))
      )}
    </div>
  );
}

export default PostList;

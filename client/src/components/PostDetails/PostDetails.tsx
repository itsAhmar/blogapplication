import React, { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { API_URL } from "../../constants";
import axios from "axios";
import { useNavigate } from 'react-router-dom';

interface Post {
  id: number;
  title: string;
  description: string;
  image_url?: string;
}

function PostDetails() {
  const [post, setPost] = useState<Post | null>();
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();

  useEffect(() => {
    async function fetchCurrentPost() {
      try {
        const response = await axios.get(`${API_URL}/${id}`);
        setPost(response.data);
      } catch (e) {
        console.error("Error:", e);
      }
    }
    fetchCurrentPost();
  }, [id]);

  const deletePost = async () => {
    try {
      const response = await axios.delete(`${API_URL}/${id}`);
      console.log(response.data)
      navigate(`/posts`);
    } catch (error) {
      console.error('Error deleting post:', error);
    }
  }

  if (!post) return <h2>Loading...</h2>;

  return (
    <div>
      <div className="flex justify-center p-5">
        {post.image_url && (
          <img src={post.image_url} alt={post.title} className="h-[400px] w-[400px] rounded-md object-cover" />
        )}
      </div>
      <h2>Title: {post.title}</h2>
      <p>Description: {post.description}</p>
      {/* <Link to="/posts/:id/edit">Edit Post</Link> */}
      <Link to={`/posts/${post.id}/edit`}>Edit Post</Link>
      {" | "}
      <Link to="/">Back to Posts</Link>
      <br/>
      <button className=' m-5 bg-red-600' onClick={deletePost}>Delete Post</button>
    </div>
  );
}

export default PostDetails;

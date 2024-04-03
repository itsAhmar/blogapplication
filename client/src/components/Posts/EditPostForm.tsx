import React, { useEffect, useState } from "react";
import { API_URL } from "../../constants";
import { useParams } from "react-router-dom";
import axios from 'axios';
import { useForm, SubmitHandler } from "react-hook-form";
import { useNavigate } from 'react-router-dom';

interface Post {
  id: string;
  title: string;
  description: string;
  image: File;
}

function PostList() {
  const [post, setPost] = useState<Post>();
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const [postId, setPostId] = useState<String | null>(null)
  const { id } = useParams();
  const { register, handleSubmit } = useForm<Post>();
  const navigate = useNavigate();

  useEffect(() => {
    if(id) setPostId(id);
    async function loadPosts() {
      try {
        const response = await fetch(`${API_URL}/${id}/edit`);
        if (response.ok) {
          const res = await response.json();
          setPost(res);
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
  }, [id]);


  const onSubmit: SubmitHandler<Post> = async (data) => {
    try {
      const response = await axios.patch(`${API_URL}/${postId}`, data);
      const { id } = response.data;
      navigate(`/posts/${id}`);
    } catch (error) {
      console.error('Error submitting post:', error);
    }
  }

  if (loading) return <h2>Loading...</h2>;
  if (error) return <h2>{error}</h2>;

  return (
    <>
      <h1>Edit</h1>
      <form onSubmit={handleSubmit(onSubmit)}>
        <label htmlFor='title'>Title</label>
        <input className="border block rounded-md" type="text" id="title" defaultValue={post?.title} {...register("title")} />

        <label htmlFor='description'>Description</label>
        <textarea className='border block rounded-md' id="description" defaultValue={post?.description} {...register("description")} />
      {/* <label htmlFor='image'>Image</label>
        <input className="border block rounded-md" type="file" id="image" {...register("image")} /> */}

        <button className='m-5 bg-green-600'>Submit</button>
      </form>
    </>
  );
}

export default PostList;

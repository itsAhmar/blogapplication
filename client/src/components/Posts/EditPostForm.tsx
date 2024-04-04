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
  image: File[];
  image_url: string;
}

function PostList() {
  const [post, setPost] = useState<Post>();
  const [postImage, setPostImage] = useState<string | null>(null);
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
        const response = await axios.get(`${API_URL}/${id}/edit`);
        setPost(response.data);
        setPostImage(response.data.image_url);
      } catch (e) {
        setError("Error");
      } finally {
        setLoading(false);
      }
    }
    loadPosts();
  }, [id]);

  const handleImageChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      const imageUrl = URL.createObjectURL(file);
      setPostImage(imageUrl);
    }
  };

  const onSubmit: SubmitHandler<Post> = async (data) => {
    const formData = new FormData();
    formData.append('post[title]', data.title);
    formData.append('post[description]', data.description);
    formData.append('post[image]', data.image[0]);

    try {
      const response = await axios.patch(`${API_URL}/${postId}`, formData);
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

        <label htmlFor='image'>Image</label>
        <div className="post-container w-[400px] rounded-md border p-5 m-5">
          {postImage && (
            <img
              src={postImage}
              alt={post?.title}
              className="h-[400px] w-full rounded-md object-cover"
            />
          )}
        </div>
        <input className="border block rounded-md" type="file" id="image" {...register("image")} onChange={handleImageChange} />

        <button className='m-5 bg-green-600'>Submit</button>
      </form>
    </>
  );
}

export default PostList;

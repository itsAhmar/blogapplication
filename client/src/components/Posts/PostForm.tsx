import { useForm, SubmitHandler } from "react-hook-form"
import { useNavigate } from 'react-router-dom';
import { API_URL } from "../../constants";
import axios from 'axios';

type Post = {
  title: string;
  description: string;
  image: File[];
}

const PostForm = () => {
  const navigate = useNavigate();
  const onSubmit: SubmitHandler<Post> = async (data) => {
    const formData = new FormData();
    formData.append('post[title]', data.title);
    formData.append('post[description]', data.description);
    formData.append('post[image]', data.image[0]);
    try {
      const response = await axios.post(API_URL, formData);
      const { id } = response.data;
      navigate(`/posts/${id}`);
    } catch (error) {
      console.error('Error submitting post:', error);
    }
  }

  const { register, handleSubmit } = useForm<Post>();

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <label htmlFor='title'>Title</label>
      <input className="border block rounded-md" type="text" id="title" {...register("title")} />

      <label htmlFor='description'>Description</label>
      <textarea className='border block rounded-md' id="description" {...register("description")} />

      <label htmlFor='image'>Image</label>
      <input className="border block rounded-md" type="file" id="image" {...register("image")} />

      <button className='m-5 bg-green-600'>Submit</button>
    </form>
  )
}

export default PostForm;

import { useForm, SubmitHandler } from "react-hook-form";
import { gql, useMutation } from '@apollo/client';


const CREATE_POST = gql`
  mutation CreatePost($title: String!, $description: String!) {
    createPost(input: { title: $title, description: $description }) {
      post {
        title
        description
      }
      errors
    }
  }`;

const PostForm = () => {

  const { register, handleSubmit } = useForm<Post>();
  const [createPost, { data, loading, error }] = useMutation(CREATE_POST);

  type Post = {
    title: string;
    description: string;
    image: File[];
  }

  const onSubmit: SubmitHandler<Post> = async (data) => {
    try {
      const { title, description, image } = data;
      await createPost({
        variables: { title, description }
      });
    } catch (error) {
      console.error('Error submitting post:', error);
    }
  }

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

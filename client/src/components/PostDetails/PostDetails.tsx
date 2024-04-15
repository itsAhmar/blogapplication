import React, { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { useNavigate } from 'react-router-dom';
import { useQuery, gql } from '@apollo/client';

const FIND_POST = gql`
  query ShowPost($id: ID!) {
    getPost(id: $id) {
      id
      title
      description
      image
    }
  }
`;

interface Post {
  id: number;
  title: string;
  description: string;
  image?: string;
}

function PostDetails() {
  const [post, setPost] = useState<Post | null>();
  const { id } = useParams<{ id: string }>();
  const { loading, error, data } = useQuery(FIND_POST, { variables: { id } });

  useEffect(() => {
    if (data) {
      setPost(data.getPost);
    }
  }, [data]);

  if (!post) return <h2>Loading...</h2>;

  return (
    <div>
      <div className="flex justify-center p-5">
        {post.image && (
          <img src={post.image} alt={post.title} className="h-[400px] w-[400px] rounded-md object-cover" />
        )}
      </div>
      <h2>Title: {post.title}</h2>
      <p>Description: {post.description}</p>
      <Link to={`/posts/${post.id}/edit`}>Edit Post</Link>
      {" | "}
      <Link to="/">Back to Posts</Link>
      <br/>
      {/* <button className=' m-5 bg-red-600' onClick={deletePost}>Delete Post</button> */}
    </div>
  );
}

export default PostDetails;

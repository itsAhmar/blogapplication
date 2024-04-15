import React, { useEffect, useState } from "react";
import PostCard from "./PostCard";
import { useQuery, gql } from '@apollo/client';

interface Post {
  id: number;
  title: string;
  description: string;
  image_url: string;
}

const FIND_POSTS = gql`
  query ShowPosts {
    getPosts {
      id
      title
      description
      image
    }
  }`
;

function PostList() {
  const [posts, setPosts] = useState<Post[]>([]);
  const { loading, error, data } = useQuery(FIND_POSTS);

  useEffect(() => {
    if(data){
      setPosts(data.getPosts);
    }
  }, [data]);

  return (
    <div>
      {loading ? (
        <div>Loading...</div>
      ) : (
        posts.map((post) => (
          <div key={post.id}>
            <PostCard post={post} />
          </div>
        ))
      )}
    </div>
  );
}

export default PostList;

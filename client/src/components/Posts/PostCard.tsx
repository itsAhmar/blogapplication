import { Link } from "react-router-dom";

interface Post {
  id: number;
  title: string;
  description: string;
  image_url?: string;
}

function PostCard({ post }: { post: Post }) {
  return (
    <Link to={`/posts/${post.id}`} className="post-link">
      <div className="post-container w-[400px] rounded-md border p-5 m-5">
        {post.image_url && (
          <img
            src={post.image_url}
            alt={post.title}
            className="h-[400px] w-full rounded-md object-cover"
          />
        )}
        <div className="p-4">
          <h1 className="text-lg font-semibold">{post.title}</h1>
        </div>
      </div>
    </Link>
  );
}

export default PostCard;

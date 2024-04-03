import React from 'react'

interface Post {
  id: number;
  title: string;
  description: string;
  image_url?: string; // Optional property for image URL
}

function PostCard({ post }: { post: Post }) {
  return (
    <div className="post-container w-[400px] rounded-md border px-5 m-5">
      {post.image_url && (
        <img
          src={post.image_url}
          alt={post.title}
          className="h-[400px] w-full rounded-md object-cover"
        />
      )}
      <div className="p-4">
        <h1 className="text-lg font-semibold">{post.title}</h1>
        <p className="mt-3 text-sm text-gray-600">{post.description}</p>
        <button
          type="button"
          className="mt-4 rounded-sm bg-black px-2.5 py-1 text-[10px] font-semibold text-white shadow-sm hover:bg-black/80 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-black"
        >
          Read me
        </button>
      </div>
    </div>
  )
}

export default PostCard
 
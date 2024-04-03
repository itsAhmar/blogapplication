import { Routes } from "react-router-dom";
import { Route } from "react-router-dom";
import PostList from "../Posts/PostList";
import PostDetails from "../PostDetails/PostDetails";
import PostForm from "../Posts/PostForm";
import EditPostForm from "../Posts/EditPostForm"
import React from 'react'

function AppRoutes() {
  return (
    <Routes>
      <Route path="/" element={<PostList/>}/>
      <Route path="/posts" element={<PostList/>}/>
      <Route path="posts/:id" element={<PostDetails/>}/>
      <Route path="posts/:id/edit" element={<EditPostForm/>}/>
      <Route path="posts/new" element={<PostForm/>}/>
    </Routes>
  )
}

export default AppRoutes

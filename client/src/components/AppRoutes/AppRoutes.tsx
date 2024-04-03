import { Routes } from "react-router-dom";
import { Route } from "react-router-dom";
import PostList from "../Posts/PostList";
import PostDetails from "../PostDetails/PostDetails";
import PostForm from "../Posts/PostForm";
import React from 'react'

function AppRoutes() {
  return (
    <Routes>
        <Route path="/" element={<PostList/>}/>
        <Route path="posts/:id" element={<PostDetails/>}/>
        <Route path="/new" element={<PostForm/>}/>
    </Routes>
  )
}

export default AppRoutes

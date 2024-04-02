import { Routes } from "react-router-dom";
import { Route } from "react-router-dom";
import PostList from "../Posts/PostList";
import PostDetails from "../PostDetails/PostDetails";
import React from 'react'

function AppRoutes() {
  return (
    <Routes>
        <Route path="/" element={<PostList/>}/>
        <Route path="posts/:id" element={<PostDetails/>}/>
        <Route path="/new" element={<h1>New Post Form</h1>}/>
    </Routes>
  )
}

export default AppRoutes
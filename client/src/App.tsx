import { useState } from 'react'
import './App.css'
import PostList from './components/Posts/PostList'

function App() {
  return (
    <>
      <div className='app'>
        <h1>Posts</h1>
        <PostList />
      </div>
    </>
  )
}

export default App

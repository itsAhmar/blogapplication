import { useState } from "react";
import  {BrowserRouter as Router} from "react-router-dom";
import "./App.css";
import NavBar from "./components/NavBar/NavBar"
import AppRoutes from "./components/AppRoutes/AppRoutes"

function App() {
  return (
    <Router>
      <div className="app">
        <h1>Posts</h1>
        <NavBar/>
        <AppRoutes />
      </div>
    </Router>
  );
}

export default App;

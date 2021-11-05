import React, { useState } from "react";
// import MenuIcon from "@material-ui/icons/Menu";
// import Sidebar from "./Sidebar";
import { Link, NavLink } from "react-router-dom";
import "./Header.css";
import { BrowserRouter as Router, Route, useHistory } from "react-router-dom";
import UserInput from "../LoginPage/UserInput";
import Login from "../LoginPage/Login";

const Header = () => {
  return (
    <header className="header">
      <div className="menu">
        <Link className="links" to="/" style={{ textDecoration: "none" }}>
          <strong>Vac</strong>Check
        </Link>
      </div>

      <nav className="navbar">
        <Router>
          <li>
            <Link to="welcome" smooth={true} style={{ textDecoration: "none" }}>
              Welcome
            </Link>
          </li>

          <li>
            <Link to="about" smooth={true} style={{ textDecoration: "none" }}>
              About
            </Link>
          </li>

          <li>
            <Link to={"/Login"} style={{ textDecoration: "none" }}>
              LogIn
            </Link>
          </li>
        </Router>
      </nav>
    </header>
  );
};

export default Header;

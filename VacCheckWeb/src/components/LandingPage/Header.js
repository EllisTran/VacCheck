import React from "react";
import { Link } from "react-scroll";
import "./Header.css";
import { Link as Linker } from "react-router-dom";


const Header = () => {
  return (
    <header className="header">
      <div className="menu">
        <Link className="links" to="/" style={{ textDecoration: "none" }}>
          <strong>Vac</strong>Check
        </Link>
      </div>

      <nav className="navbar">
        <li>
          <Link
            to="demo"
            smooth={true}
            duration={10}
            style={{ textDecoration: "none" }}
          >
            Demo
          </Link>
        </li>

        <li>
          <Link
            to="about"
            smooth={true}
            offset={70}
            duration={10}
            style={{ textDecoration: "none" }}
          >
            About
          </Link>
        </li>

        <li>
          <Linker to="/VacCheckWeb/Login" style={{ textDecoration: "none" }}>
            Login
          </Linker>
        </li>
      </nav>
    </header>
  );
};

export default Header;

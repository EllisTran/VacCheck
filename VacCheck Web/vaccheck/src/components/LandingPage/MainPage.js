import React from "react";
import { Route, Router, Link } from "react-router-dom";
import "./MainPage.css";
import UserInput from "../LoginPage/UserInput";
import Login from "../LoginPage/Login";


const Mainpage = () => {
  return (
    <>
      <section className="mainpage">
        <div className="overlay">
          <h1>
            Keep a digital version of your  <br/> COVID-19 vaccine card <br/>right in your phone.
          </h1>
          <p1>
            VacCheck offers the easiest and safest way for the community to help
            cutting the transmission of the virus <br />
            by allowing safe and clear communication between health
            professionals, businesses, and the community
          </p1>
        </div>
      </section>

      
    </>
  );
};

export default Mainpage;

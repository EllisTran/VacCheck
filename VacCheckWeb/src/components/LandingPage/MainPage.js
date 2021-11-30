import React from "react";
import "./MainPage.css";
import Header from "./Header";
import About from "./About";
import Demo from "./Demo";
import ScrollButton from "./ScrollButton";

const Mainpage = () => {
  return (
    <>
      <Header />

      <section className="mainpage">
        <div className="overlay">
          <h1>
            Keep a digital version of your <br /> COVID-19 vaccination card{" "}
            <br />
            right on your phone.
          </h1>
          <p1>
            VacCheck offers the easiest and safest way for the community to help
            cutting the transmission <br />
            by allowing safe and clear communication between health
            professionals, businesses, and the community
          </p1>
        </div>
      </section>
      <Demo />
      <About />
      <ScrollButton />
    </>
  );
};

export default Mainpage;

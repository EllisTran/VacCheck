import React from "react";
import "./MainPage.css";
import Header from "./Header";
import About from "./About";
import Demo from "./Demo";
import ScrollButton from "./ScrollButton";
import image4 from "../../assets/mockup1.png";

const Mainpage = () => {
  return (
    <>
      <Header />

      <section className="mainpage">
        <div className="overlay">
          <div className="img4">
            <img src={image4} alt="" width="50%" height="50%" />
          </div>

          <h1>
            Keep a digital version of your <br /> COVID-19 vaccination card
            <br />
            right on your phone.
          </h1>
          <p1>
            VacCheck offers the easiest and safest way for the community <br />
            to help cutting the transmission by allowing safe and clear
            communication
            <br />
            between health professionals, businesses, and the community
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

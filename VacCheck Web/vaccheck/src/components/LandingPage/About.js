import React from "react";
import "./About.css";
import image1 from "../../assets/Ellis3.jpeg";
import image2 from "../../assets/Patrick5.JPEG";
import image3 from "../../assets/Sungwoo.jpeg";
import image4 from "../../assets/Yaling.jpeg";
import image5 from "../../assets/Yudong3.jpeg";

const About = () => {


  return (
    
    <div className="about">
      <section className="grid">
        <h5> Meet The Team </h5>

        <div className="grid-items">
          <div class="item--1ET">
            <img
              className="image1"
              src={image1}
              alt=""
              width="100%"
              height="60%"
            />
          </div>
          <div class="item--2ET_d">
            <h1> Ellis Tran </h1>
            <p10> Team Leader </p10>
            <p5>
              Ellis Tran is the leader and one of the mobile developers of
              VacCheck. He will be receiving his B.S. in Computer Science at the
              University of Arkansas in December 2021. Starting January 2022, he
              will be starting his Professional Masters in Bioengineering with a
              focus in Neural Engineering. His biggest aspiration is to create
              neural implants to help treat neural disorders.
            </p5>
          </div>
          <div class="item--3SK">
            <img
              className="image3"
              src={image3}
              alt=""
              width="100%"
              height="70%"
            />
          </div>
          <div class="item--4SK_d">
            <h3> SungWoo Kim </h3>
            <p12> Web developer </p12>
            <p7>
              SungWoo Kim is one of the web developer of vacCheck. He is in his
              senior year majoring in Computer Science at the University of
              Arkansas. He's expected graduation date is May 2022. He will
              actively be in search of further working experience focusing in
              the area of software engineering.
            </p7>
          </div>

          <div class="item--5PK">
            <img
              className="image2"
              src={image2}
              alt=""
              width="100%"
              height="70%"
            />
          </div>
          <div class="item--6PK_d">
            <h2> Patrick Kwok </h2>
            <p11> Mobile developer </p11>
            <p6>
              Patrick Kwok is a senior Computer Science major with a minor in
              Mathematics at the University of Arkansas. He is a proficient
              Mobile Developer with a demonstrated history of working as a
              mobile development intern at X/Link Software in Jakarta,
              Indonesia.
            </p6>
          </div>

          <div class="item--7YL">
            <img
              className="image4"
              src={image4}
              alt=""
              width="100%"
              height="75%"
            />
          </div>
          <div class="item--8YL_d">
            <h4> Yaling Liu </h4>
            <p13> Web developer </p13>
            <p8>
              Yaling Liu is in her last semester at the University of Arkansas
              as a student in Computer Science. She is one of the web developers
              of VacCheck. After graduation she will work as an assistant
              researcher in the fields of cybersecurity and artificial
              intelligence.
            </p8>
          </div>

          <div class="item--9YD">
            <img
              className="image5"
              src={image5}
              alt=""
              width="100%"
              height="70%"
            />
          </div>
          <div class="item--10YD_d">
            <h6> Yudong Wang </h6>
            <p14> Web developer </p14>
            <p9>
              Yudong Wang is a senior Computer Science major at the University
              of Arkansas. He is one of the web developers of VacCheck. He will
              work as a web developer after graduate. Also, he will try to apply
              master at University of Arkansas Computer Science and Computer
              Engineering department.
            </p9>
          </div>
        </div>
      </section>
    </div>
  );
};

export default About;

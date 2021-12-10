import React from "react";
import "./Demo.css";
import ReactPlayer from "react-player";

const Demo = () => {
  return (
    <section className="demo">
      <h3>This is our Demo</h3>

      <div className="player-wrapper">
        <ReactPlayer
          className="react-player"
          url="Demo.mp4"
          playing
          muted
          loop
          config={{
            file: {
              attributes: {
                autoPlay: true,
                muted: true,
              },
            },
          }}
          width="1000px"
          height="550px"
          controls={true}
        />
      </div>
      <p4>
        All you need is your <strong> Phone.</strong>
      </p4>
    </section>
  );
};

export default Demo;

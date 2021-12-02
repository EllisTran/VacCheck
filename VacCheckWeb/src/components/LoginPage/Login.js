import React from "react";
import "../styling/Login.css";
import "../styling/AccountFilter.css";
import { ReactComponent as Vector2 } from '../styling/Vector2.svg';
import graphic from "../../assets/GraphicLogin.png"
import { ReactComponent as Vector4 } from '../styling/Vector4.svg';
import { ReactComponent as VectorLeftCard } from "../styling/VectorLeftCard.svg";
import { ReactComponent as VectorSyringe } from "../styling/VectorSyringe.svg";

const Login = (props) => {
  const {
    email,
    setEmail,
    password,
    setPassword,
    handleLogin,
    handleSignup,
    hasAccount,
    setHasAccount,
    emailError,
    passwordError,
  } = props;

  return (
    <div className="grid-container">
      <div className="center">
        <div className="logo-container">
          <Vector2 />
          <h1 className="logo">VacCheck</h1>
        </div>
        <div>
          <div>
            <div>
              <h3 className="title">Sign In</h3>
              <div className="loginSubtext">
                Sign in to stay connected.
              </div>
            </div>
          </div>
          <div>
            <div className="labelMargin">
              <label className="labels">Email</label>
            </div>
            <div className="inputMargin">
              <input className="textBox" style={{ width: "100%" }} type="text" autoFocus required value={email} onChange={(e) => setEmail(e.target.value)} />
              <span className="ErrorMsg">{emailError}</span>
            </div>
          </div>
          <div>
            <div className="labelMargin">
              <label className="labels">Password</label>
            </div>
            <div className="inputMargin">
              <input className="textBox" style={{ width: "100%" }} type="password" required value={password} onChange={(e) => setPassword(e.target.value)} />
              <span className="ErrorMsg">{passwordError}</span>
            </div>
          </div>
          <div className="btndiv">
            <button className="btn3" type="submit" onClick={handleLogin}>Sign in</button>

          </div>
          <div className="signup">
            Don't have an account? <span style={{ paddingLeft: "5px", color: "#3A57E8"}} onClick={handleSignup}>Click here to sign up.</span>
          </div>
        </div>

      </div>
      <div>
        <img src={graphic} alt="graphic" className="photo" />
      </div>
      <VectorLeftCard className="VectorCardLogin" />
      <Vector4 className="VectorCardSquare" />
      <VectorSyringe className="VectorSyringe" />
    </div>
  );
};

export default Login;

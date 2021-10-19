
import "./App.css";
import React, { useState, useEffect } from "react";
import db from "../src/firebase";
import Login from "./components/Login";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom"; 
import { useHistory } from "react-router-dom";
import SignupPage from "../src/components/SignupPage/SignupPage";

const App = () => {
  const [user, setUser] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [emailError, setEmailError] = useState(""); //for error-case(email)
  const [passwordError, setPasswordError] = useState(""); //for error-case(password)
  const [hasAccount, setHasAccount] = useState(false); //for switch in signin - login

  const clearInputs = () => {
    setEmail("");
    setPassword("");
  };

  const clearErrors = () => {
    setEmailError("");
    setPasswordError("");
  };

  const handleLogin = () => {
    clearErrors();
    db
      .auth()
      .signInWithEmailAndPassword(email, password)
      .catch((err) => {
        // console.log(fire);
        // catching errors
        switch (err.code) {
          case "auth/invalid-email":
          case "auth/user-disabled":
          case "auth/user-not-found":
            setEmailError(err.message);
            break;
          case "auth/wrong-password":
            setPasswordError(err.message);
            break;
        }
      });
  };

  const handleSignup = () => {
    // let history = useHistory();
    // history.push("/SignupPage");

    clearErrors();
    db
      .auth()
      .createUserWithEmailAndPassword(email, password).then(data => {
        console.log("User ID :- ", data.user.uid);
      })  
      .catch((err) => {
       
        // catching errors
        switch (err.code) {
          case "auth/email-already-in-use":
          case "auth/invalid-email":
            setEmailError(err.message);
            break;
          case "auth/weak-password":
            setPasswordError(err.message);
            break;
        }
      });
  };

  const handleLogOut = () => {
    db.auth().signOut();
  };

  const authListener = () => {
    db.auth().onAuthStateChanged((user) => {
      if (user) {
        clearInputs();
        setUser(user);
      } else {
        setUser("");
      }
    });
  };

  useEffect(() => {
    authListener();
  }, []);

  return (
    <div className="app">
      <Router>
      <Switch>
        <Route exact path="/SignupPage">
        </Route>
      </Switch>
    </Router>
      <Login //props for Login.
        email={email}
        setEmail={setEmail}
        password={password}
        setPassword={setPassword}
        handleLogin={handleLogin}
        handleSignup={handleSignup}
        hasAccount={hasAccount}
        setHasAccount={setHasAccount}
        emailError={emailError}
        passwordError={passwordError}
      />
    </div>
  );
};

export default App;

import React, { useState, useEffect, useContext } from "react";
import Login from "./Login";
import { BrowserRouter as Router, Route, useHistory } from "react-router-dom";
import SignupPage from "../SignupPage/SignupPage";
import { auth, db } from "../../firebase";
import MainPage from "../HealthProfessionalPage/HealthProfessionalPage";

const LoginPage = () => {
  const history = useHistory();
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
    auth.signInWithEmailAndPassword(email, password)
    .then((user) => {
      db.collection("users").where('email', '==', email).get().then(result => {
        result.docs.forEach(doc => {
            if (doc.data().userType.isHealthProfessional) {
              history.push("/VacCheckWeb/HealthProfessional");
            }
        })
      });
    }).catch((err) => {
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
    history.push("/VacCheckWeb/SignupPage");
  };

  const handleSignupSuccess = () => {
    console.log("Success");
      history.push("/VacCheckWeb/Login");
  }

  const handleLogOut = () => {
    auth.signOut().then(function() {
      console.log('Signed Out');
    }, function(error) {
      console.error('Sign Out Error', error);
    });;
  };

  const authListener = () => {
    auth.onAuthStateChanged((user) => {
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
    <div className="userinput">
      <switch>
        <Route exact path="/VacCheckWeb/healthprofessional" component={MainPage}>
          <MainPage handleLogOut={handleLogOut}/>
        </Route>
        <Route exact path="/VacCheckWeb/Login" component={Login}>
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
        </Route>
        <Route exact path="/VacCheck/SignupPage" component={SignupPage}>
          <SignupPage handleSignupSuccess={handleSignupSuccess}/>
        </Route>
      </switch>
    </div>
  );
};

export default LoginPage;
